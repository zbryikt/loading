define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-cube', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [{
        name: 'color',
        placeholder: '#f00',
        type: 'color',
        'default': '#000',
        attr: 'color'
      }],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        var i$, i, begin;
        data = data.replace(/#000|black/g, opt.c1 + "");
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        data = data.replace(/"uil-cube-css"/, "'uil-cube-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
        for (i$ = 4; i$ >= 1; --i$) {
          i = i$;
          begin = parseInt(((i - 1) * opt.speed / 10) * 100) / 100 + "s";
          data = data.replace(new RegExp("begin" + i, "g"), begin);
        }
        return data;
      },
      custom: function(s, e, a, c){
        a.$observe('color', function(v){
          if (v) {
            return e.find('rect.cube').css('fill', v);
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
        return e.find('rect.cube').each(function(){
          var i, s;
          i = arguments[0];
          if (i === 2) {
            i = 3;
          } else if (i === 3) {
            i = 2;
          }
          s = 1.0 + 0.3 * Math.pow(((2000 - delay + i * 100) % 1000) / 1000, 2);
          return $(arguments[1]).attr('transform', "scale(" + s + ")");
        });
      }
    };
  });
  return x$;
});
