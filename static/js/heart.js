define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-heart', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [{
        name: 'color',
        placeholder: '#f02',
        type: 'color',
        'default': '#f02',
        attr: 'color'
      }],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/color/g, opt.c1);
        data = data.replace(/1s/g, opt.speed + "s");
        return data = uilresize(data, 'heart', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('color', function(v){
          if (v) {
            return e.find("path").css('fill', v);
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
        return e.find("svg > g > g").each(function(){
          var v;
          v = (delay % 1000) / 1000;
          if (v < 0.3) {
            v = 1.25 - 0.4 * ((0.09 - Math.pow(0.3 - v, 2)) / 0.09);
          } else {
            v = 1.1 - 0.2 * ((0.49 - Math.pow(0.7 - v, 2)) / 0.49);
          }
          return $(arguments[1]).attr('transform', "scale(" + v + ")");
        });
      }
    };
  });
  return x$;
});
