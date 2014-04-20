define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-flickr', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [
        {
          name: 'color1',
          placeholder: '#06d',
          type: 'color',
          'default': '#0462dc',
          attr: 'color1'
        }, {
          name: 'color2',
          placeholder: '#f08',
          type: 'color',
          'default': '#fc0284',
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
        data = data.replace(/color1/g, opt.c1);
        data = data.replace(/color2/g, opt.c2);
        data = data.replace(/1s/g, opt.speed + "s");
        return data = uilresize(data, 'flickr', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('color1', function(v){
          if (v) {
            return e.find("circle:nth-of-type(2n+1)").css('fill', v);
          }
        });
        a.$observe('color2', function(v){
          if (v) {
            return e.find("circle:nth-of-type(2)").css('fill', v);
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
          var o, v, x;
          o = (delay % 1000) / 1000;
          v = 2 * Math.abs(500 - delay % 1000) / 1000;
          if (arguments[0] % 2 === 0) {
            x = v * 50 + 25;
          } else {
            x = (1 - v) * 50 + 25;
          }
          $(arguments[1]).attr('cx', x);
          if (arguments[0] === 2) {
            return $(arguments[1]).attr('opacity', o >= 0.5 ? 1 : 0);
          }
        });
      }
    };
  });
  return x$;
});
