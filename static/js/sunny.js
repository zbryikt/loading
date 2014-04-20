define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-sunny', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      speed: 1,
      vars: [
        {
          name: 'circle color',
          placeholder: '#000',
          type: 'color',
          'default': '#edb900',
          attr: 'circle-color'
        }, {
          name: 'light color',
          placeholder: '#000',
          type: 'color',
          'default': '#ff0000',
          attr: 'light-color'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/circleColor/g, opt.c1);
        data = data.replace(/lightColor/g, opt.c2);
        data = data.replace(/1s/g, opt.speed + "s");
        return data = uilresize(data, 'sunny', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('circleColor', function(v){
          if (v) {
            return e.find('circle').css('fill', v);
          }
        });
        a.$observe('lightColor', function(v){
          if (v) {
            return e.find('path').css('fill', v);
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
        return e.find('g').each(function(){
          return $(arguments[1]).attr('transform', "rotate(" + 60 * ((delay % 1000) / 1000) + " 50 50)");
        });
      }
    };
  });
  return x$;
});
