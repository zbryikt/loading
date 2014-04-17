define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-default', function($interval, uilresize){
    var offset, start, ret;
    offset = [0, 83, 166, 250, 333, 416, 500, 583, 666, 750, 833, 916, 1000];
    start = null;
    return ret = {
      mode: 'both',
      vars: [{
        name: 'bar color',
        placeholder: '#f00',
        type: 'color',
        'default': '#000',
        attr: 'bar-color'
      }],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        var i$, i, begin;
        data = data.replace(/barColor/g, opt.c1);
        data = data.replace(/bkColor/g, opt.cbk);
        data = data.replace(/duration/g, opt.speed + "s");
        data = uilresize(data, 'default', opt);
        for (i$ = 12; i$ >= 1; --i$) {
          i = i$;
          begin = parseInt(((i - 1) * opt.speed / 12) * 100) / 100 + "s";
          data = data.replace(new RegExp("begin" + i, "g"), begin);
        }
        return data;
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
