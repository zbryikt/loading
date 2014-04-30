define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-gps', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [
        {
          name: 'outer color',
          placeholder: '#000',
          type: 'color',
          'default': '#05c400',
          attr: 'outer-color'
        }, {
          name: 'inner color',
          placeholder: '#000',
          type: 'color',
          'default': '#64f241',
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
        data = data.replace(/duration/g, opt.speed + "s");
        return data = uilresize(data, 'gps', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('outerColor', function(v){
          if (v) {
            return e.find("path").css('fill', v);
          }
        });
        a.$observe('innerColor', function(v){
          if (v) {
            return e.find("circle").css('fill', v);
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
        e.find('path').each(function(){
          var v, ref$;
          v = (ref$ = 180 * (delay % 1000) / 1000) < 90 ? ref$ : 90;
          return $(arguments[1]).attr('transform', "rotate(" + v + " 50 50)");
        });
        return e.find('circle').each(function(){
          var v, ref$;
          v = (delay % 1000) / 1000;
          v = v < 0.5
            ? (ref$ = (0.5 - v) * 10) < 1 ? ref$ : 1
            : (ref$ = (v - 0.9) * 10) > 0 ? ref$ : 0;
          return $(arguments[1]).attr('opacity', v);
        });
      }
    };
  });
  return x$;
});
