define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-default', function($interval){
    var offset, start, ret;
    offset = [0, 83, 166, 250, 333, 416, 500, 583, 666, 750, 833, 916, 1000];
    start = null;
    return ret = {
      mode: 'both',
      vars: [{
        name: 'bar color',
        placeholder: '#f00',
        type: 'color',
        'default': '#000'
      }],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(svg, opt){
        return this.patch(svg, opt);
      },
      patch: function(src, opt){
        var i$, i, begin;
        src = src.replace(/barColor/g, opt.c1);
        src = src.replace(/bkColor/g, opt.cbk);
        opt.speed = 1;
        src = src.replace(/duration/g, opt.speed + "s");
        src = src.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        src = src.replace(/"uil-default-css"/, "'uil-default-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
        opt.speed = 1;
        for (i$ = 12; i$ >= 1; --i$) {
          i = i$;
          begin = parseInt(((i - 1) * opt.speed / 12) * 100) / 100 + "s";
          src = src.replace(new RegExp("begin" + i, "g"), begin);
        }
        return src;
      },
      custom: function(s, e, a, c){
        a.$observe('barColor', function(v){
          if (v) {
            return e.find('rect.bar').css('fill', v);
          }
        });
        return a.$observe('background', function(v){
          if (v) {
            return e.find('rect.bk').css('fill', v);
          }
        });
      },
      start: function(s, e, a, c){},
      stop: function(s, e, a, c){
        if (s.timer) {
          return $interval.cancel(s.timer);
        }
      },
      step: function(s, e, a, c, delay){
        return e.find("rect.bar").each(function(){
          var delta;
          delta = (delay + offset[12 - arguments[0]]) % 1000;
          return $(arguments[1]).css('opacity', delta / 1000);
        });
      }
    };
  });
  return x$;
});
