define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-g0v', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [{
        name: 'variant',
        placeholder: '',
        type: 'choice',
        values: ['rotate', 'jump'],
        attr: 'variant'
      }],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        data = data.replace(/type1/g, this.variant === 'rotate' ? "transform" : "none");
        return data = data.replace(/type2/g, this.variant === 'jump' ? "transform" : "none");
      },
      custom: function(s, e, a, c){
        var this$ = this;
        return a.$observe('variant', function(v){
          if (v) {
            return this$.variant = v;
          }
        });
      },
      start: function(s, e, a, c){},
      stop: function(s, e, a, c){},
      step: function(s, e, a, c, delay){
        var v, t, r;
        switch (this.variant) {
        case 'rotate':
          e.find(".uil-g0v > g").attr('transform', "translate(0 0) rotate(" + 360 * (delay % 1000) / 1000 + " 50 50)");
          return e.find("g > g").attr('transform', "scale(1.0 1.0)");
        case 'jump':
          v = (500 - delay % 1000) / 500;
          t = v * v * 85;
          r = v * v * v * v * 0.65;
          e.find(".uil-g0v > g").attr('transform', "translate(10 " + t + ")");
          return e.find("g > g").attr('transform', "scale(0.8 " + (0.8 - r) + ")");
        }
      }
    };
  });
  return x$;
});