define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-poi', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      radius: 15,
      variant: 1,
      vars: [
        {
          name: 'variant',
          placeholder: '',
          type: 'choice',
          'default': 'jump',
          values: ['jump', 'rotate'],
          attr: 'variant'
        }, {
          name: 'color',
          placeholder: '#f00',
          type: 'color',
          'default': '#d51',
          attr: 'color'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/uil-poi-anim-type/g, "uil-poi-anim" + this.variant);
        data = data.replace(/#000|black/g, opt.c2 + "");
        data = data.replace(/1s/g, opt.speed + "s");
        if (this.variant === 1) {
          data = data.replace(/type="translate"/g, 'type="none"');
        }
        if (this.variant === 0) {
          data = data.replace(/type="rotate"/, 'type="none"');
        }
        return data = uilresize(data, 'poi', opt);
      },
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('variant', function(v){
          this$.variant = (function(){
            switch (v) {
            case 'jump':
              return 0;
            case 'rotate':
              return 1;
            }
          }());
          e.find("path").attr('transform', "translate(0,0)");
          return e.find("svg > g > g").attr('transform', "rotate(0)");
        });
        a.$observe('color', function(v){
          if (v) {
            return e.find('path').css('fill', v);
          }
        });
        return a.$observe('background', function(v){
          if (v) {
            return e.find('rect').css('fill', v);
          }
        });
      },
      start: function(s, e, a, c){},
      stop: function(s, e, a, c){},
      step: function(s, e, a, c, delay){
        switch (this.variant) {
        case 0:
          return e.find("path").each(function(){
            var v;
            v = Math.pow((500 - delay % 1000) / 500, 2);
            return $(arguments[1]).attr('transform', "translate(0 " + (-17 + v * 34) + ")");
          });
        case 1:
          return e.find("svg > g > g").each(function(){
            var v;
            v = 360 * ((delay % 1000) / 1000);
            return $(arguments[1]).attr('transform', "rotate(" + v + ")");
          });
        }
      }
    };
  });
  return x$;
});
