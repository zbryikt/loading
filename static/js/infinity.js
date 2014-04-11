var replace$ = ''.replace;
define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-infinity', function($interval){
    var offset, ret;
    offset = [0, 100, 200, 300, 400];
    return ret = {
      path: null,
      type: 'svg',
      custom: function(s, e, a, c){
        a.$observe('circleColor', function(v){
          console.log("ok: " + v);
          if (v) {
            return e.find('circle').css('fill', v);
          }
        });
        a.$observe('lineColor', function(v){
          if (v) {
            return e.find('path').css('stroke', v);
          }
        });
        return a.$observe('speed', function(v){
          if (v) {
            v = parseFloat(replace$.call(v, /s/, ''));
            if (!v || isNaN(v)) {
              return;
            }
            return e.find("circle *").attr('dur', v + "s");
          }
        });
      },
      start: function(s, e, a, c){
        this.path = document.getElementById("uil-inf-path");
        return this.length = this.path.getTotalLength();
      },
      stop: function(s, e, a, c){},
      step: function(s, e, a, c, delay){
        var this$ = this;
        return e.find('circle').each(function(){
          var ptr;
          ptr = this$.path.getPointAtLength(this$.length * parseFloat(((delay + offset[arguments[0]]) % 1000) / 1000.0));
          $(arguments[1]).attr('cx', ptr.x);
          return $(arguments[1]).attr('cy', ptr.y);
        });
      }
    };
  });
  return x$;
});
