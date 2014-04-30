define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-magnify', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [
        {
          name: 'body color',
          placeholder: '#f00',
          type: 'color',
          'default': '#424242',
          attr: 'body-color'
        }, {
          name: 'glass color',
          placeholder: '#f00',
          type: 'color',
          'default': '#8b8bfc',
          attr: 'glass-color'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/bodyColor/g, opt.c1);
        data = data.replace(/glassColor/g, opt.c2);
        data = data.replace(/duration/g, opt.speed + "s");
        return data = uilresize(data, 'magnify', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('bodyColor', function(v){
          if (v) {
            return e.find("path").css('fill', v);
          }
        });
        a.$observe('glassColor', function(v){
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
      ctrlptr: [[15, 15], [-15, 15], [0, -10.98], [15, 15]],
      step: function(s, e, a, c, delay){
        var this$ = this;
        return e.find('g').each(function(){
          var v, d, ref$, x, y, dx, dy;
          v = (delay % 1000) / 1000;
          d = parseInt(v / 0.333);
          ref$ = this$.ctrlptr[d], x = ref$[0], y = ref$[1];
          dx = this$.ctrlptr[d + 1][0] - this$.ctrlptr[d][0];
          dy = this$.ctrlptr[d + 1][1] - this$.ctrlptr[d][1];
          x = x + dx * (v - d * 0.333) / 0.333;
          y = y + dy * (v - d * 0.333) / 0.333;
          return $(arguments[1]).attr('transform', "translate(" + x + " " + y + ")");
        });
      }
    };
  });
  return x$;
});
