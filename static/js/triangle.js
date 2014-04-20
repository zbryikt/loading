define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-triangle', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [
        {
          name: 'color1',
          placeholder: '#000',
          type: 'color',
          'default': '#ffdb00',
          attr: 'color1'
        }, {
          name: 'color2',
          placeholder: '#000',
          type: 'color',
          'default': '#ffdb00',
          attr: 'color2'
        }, {
          name: 'color3',
          placeholder: '#000',
          type: 'color',
          'default': '#ffdb00',
          attr: 'color3'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/color1/g, opt.c1);
        data = data.replace(/color2/g, opt.c2);
        data = data.replace(/color3/g, opt.c3);
        data = data.replace(/1s/g, opt.speed + "s");
        return data = uilresize(data, 'triangle', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('color1', function(v){
          if (v) {
            return e.find("path:nth-of-type(1)").css('fill', v);
          }
        });
        a.$observe('color2', function(v){
          if (v) {
            return e.find("path:nth-of-type(2)").css('fill', v);
          }
        });
        a.$observe('color3', function(v){
          if (v) {
            return e.find("path:nth-of-type(3)").css('fill', v);
          }
        });
        return a.$observe('background', function(v){
          if (v) {
            return e.find('rect.bk').css('fill', v);
          }
        });
      },
      start: function(s, e, a, c){},
      stop: function(s, e, a, c){},
      rotate: function(idx, v){
        switch (idx) {
        case 0:
          return "rotate(" + v + " 33 35)";
        case 1:
          return "rotate(" + v + " 67 35)";
        case 2:
          return "rotate(" + v + " 50 65)";
        }
      },
      step: function(s, e, a, c, delay){
        var this$ = this;
        return e.find('path').each(function(){
          var v;
          v = 120 * (delay % 1000) / 1000;
          return $(arguments[1]).attr('transform', this$.rotate(arguments[0], v));
        });
      }
    };
  });
  return x$;
});
