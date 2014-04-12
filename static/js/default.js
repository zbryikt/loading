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
        type: 'color'
      }],
      patch: function(svg, opt){
        var i$, i, begin;
        console.log("patching default");
        svg = svg.replace(/{{barColor}}/g, opt.c1);
        svg = svg.replace(/{{bkColor}}/g, opt.cbk);
        svg = svg.replace(/{{dur}}/g, opt.speed + "s");
        svg = svg.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        for (i$ = 1; i$ <= 12; ++i$) {
          i = i$;
          begin = i * opt.speed / 12 + "s";
          svg = svg.replace(new RegExp("{{begin" + i + "}}", "g"), begin);
        }
        return svg;
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
