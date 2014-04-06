define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-default', function($interval){
    var offset, intpPercent, intpValue, start, intpFunc, ret;
    offset = [0, 125, 250, 375, 500, 625, 750, 875];
    intpPercent = [0, 250, 500, 510, 750, 1000];
    intpValue = [0.42, 0.26, 0.1, 1.0, 0.8, 0.54];
    start = null;
    intpFunc = function(now){
      var len, ep, sp, ev, sv;
      len = intpPercent.filter(function(it){
        return it < now;
      }).length;
      ep = intpPercent[len];
      sp = intpPercent[len - 1];
      ev = intpValue[len];
      sv = intpValue[len - 1];
      return (ev - sv) * (now - sp) / (ep - sp) + sv;
    };
    return ret = {
      start: function(s, e, a, c){
        var this$ = this;
        return s.timer = $interval(function(){
          var now;
          if (start === null) {
            start = new Date().getTime();
          }
          now = new Date().getTime();
          return this$.step(s, e, a, c, now);
        }, 30);
      },
      stop: function(s, e, a, c){
        if (s.timer) {
          return $interval.cancel(s.timer);
        }
      },
      step: function(s, e, a, c, delay){
        return e.find(".uil-default > div > div").each(function(){
          var delta;
          delta = (delay + offset[7 - arguments[0]]) % 1000;
          return $(arguments[1]).css('opacity', intpFunc(delta));
        });
      }
    };
  });
  return x$;
});
