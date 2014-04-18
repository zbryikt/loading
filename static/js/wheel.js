define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-wheel', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [
        {
          name: 'color',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'color'
        }, {
          name: 'opacity',
          placeholder: '0.5',
          type: 'px',
          'default': '0.9',
          attr: 'opacity'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/#000|black/g, opt.c1 + "");
        data = data.replace(/0.9/g, opt.c2 + "");
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        return data = data.replace(/"uil-wheel-css"/, "'uil-wheel-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
      },
      custom: function(s, e, a, c){
        a.$observe('color', function(v){
          if (v) {
            return e.find('circle').css('stroke', v);
          }
        });
        a.$observe('opacity', function(v){
          if (v) {
            return e.find('circle').attr('opacity', v);
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
        return e.find('circle').attr('stroke-dashoffset', 110 * (delay % 1000) / 1000);
      }
    };
  });
  return x$;
});
