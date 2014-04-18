define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-battery', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [
        {
          name: 'outer color',
          placeholder: '#000',
          type: 'color',
          'default': '#10004f',
          attr: 'outer-color'
        }, {
          name: 'inner color',
          placeholder: '#0f0',
          type: 'color',
          'default': '#00e62c',
          attr: 'inner-color'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/outerColor/g, opt.c1);
        data = data.replace(/innerColor/g, opt.c2);
        data = data.replace(/1s/g, opt.speed + "s");
        data = uilresize(data, 'battery', opt);
        return data;
      },
      custom: function(s, e, a, c){
        a.$observe('outerColor', function(v){
          if (v) {
            return e.find("path").css('fill', v);
          }
        });
        a.$observe('innerColor', function(v){
          if (v) {
            return e.find("rect.cell").css('fill', v);
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
      step: function(s, e, a, c, delay){
        var this$ = this;
        return e.find('rect.cell').each(function(){
          var v, ref$, ref1$;
          v = (delay % 1000) / 1000;
          v = (ref$ = ((ref1$ = v - (arguments[0] * 0.2 + 0.1)) > 0 ? ref1$ : 0) / 0.2) < 1 ? ref$ : 1;
          return $(arguments[1]).attr('opacity', v);
        });
      }
    };
  });
  return x$;
});
