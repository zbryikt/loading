define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-ball', function($interval){
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
          'default': '#000',
          attr: 'color'
        }, {
          name: 'radius',
          placeholder: '15',
          type: 'px',
          'default': '15',
          attr: 'radius'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/uil-ball-anim-type/g, "uil-ball-anim" + this.variant);
        data = data.replace(/#000|black/g, opt.c2 + "");
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/15/g, opt.c3 + "");
        data = data.replace(/ballRadius2/g, 4 * opt.c3 + "px");
        data = data.replace(/ballRadius/g, 2 * opt.c3 + "px");
        if (this.variant === 1) {
          data = data.replace(/attributeName="cy"/, "");
        }
        if (this.variant === 0) {
          data = data.replace(/attributeName="transform"/, "");
          data = data.replace(/translate\(30 0\)/, "");
        }
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        return data = data.replace(/"uil-ball-css"/, "'uil-ball-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
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
            case 'rubberband':
              return 2;
            }
          }());
          e.find('circle').attr('transform', this$.variant === 1 ? "translate(30 0)" : "translate(0 0)").attr('cy', 0);
          return e.find("g > g").attr('transform', "rotate(0)");
        });
        a.$observe('color', function(v){
          if (v) {
            return e.find('circle').css('fill', v);
          }
        });
        a.$observe('radius', function(v){
          if (v) {
            this$.radius = v;
            return e.find('circle').attr('r', v);
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
          return e.find('circle').each(function(){
            var v;
            v = Math.pow((500 - delay % 1000) / 500, 2);
            return $(arguments[1]).attr('cy', (-30 + v * 60) + "");
          });
        case 1:
          return e.find("g > g").each(function(){
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
