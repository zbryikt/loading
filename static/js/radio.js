define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-radio', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [
        {
          name: 'circle color',
          placeholder: '#000',
          type: 'color',
          'default': '#eb8614',
          attr: 'circle-color'
        }, {
          name: 'wave color',
          placeholder: '#000',
          type: 'color',
          'default': '#fb9610',
          attr: 'wave-color'
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
        data = data.replace(/waveColor/g, opt.c2);
        data = data.replace(/duration/g, opt.speed + "s");
        data = data.replace(/begin1/g, 0 * opt.speed / 10);
        data = data.replace(/begin2/g, 1 * opt.speed / 10);
        data = data.replace(/begin3/g, 2 * opt.speed / 10);
        return data = uilresize(data, 'radio', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('circleColor', function(v){
          if (v) {
            return e.find('circle').css('fill', v);
          }
        });
        a.$observe('waveColor', function(v){
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
        return e.find("g > *").each(function(){
          var v, ref$;
          v = (ref$ = ((delay + (2 - arguments[0]) * 100) % 1000) / 500) < 1 ? ref$ : 1;
          return $(arguments[1]).attr('opacity', v);
        });
      }
    };
  });
  return x$;
});
