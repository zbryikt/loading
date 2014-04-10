define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-infinity', function($interval){
    var offset, ret;
    offset = [0, 100, 200, 300, 400];
    return ret = {
      path: null,
      type: 'svg',
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
