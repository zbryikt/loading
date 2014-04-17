define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-comment', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [
        {
          name: 'color1',
          placeholder: '#999',
          type: 'color',
          'default': '#b2de00',
          attr: 'color1'
        }, {
          name: 'color2',
          placeholder: '#fff',
          type: 'color',
          'default': '#fff',
          attr: 'color2'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/#000|black/g, opt.c1 + "");
        data = data.replace(/#fff|white/g, opt.c2 + "");
        return data = uilresize(data, 'comment', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('color1', function(v){
          if (v) {
            return e.find("path").css('fill', v);
          }
        });
        a.$observe('color2', function(v){
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
        return e.find('circle').each(function(){
          var v, ref$, ref1$;
          v = (delay % 1000) / 1000;
          return $(arguments[1]).attr('opacity', ((ref$ = (ref1$ = v - arguments[0] * 0.2) > 0 ? ref1$ : 0) < 0.2 ? ref$ : 0.2) / 0.2);
        });
      }
    };
  });
  return x$;
});
