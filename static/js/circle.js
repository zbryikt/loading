define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-circle', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [
        {
          name: 'color1',
          placeholder: '#000',
          type: 'color',
          'default': '#f00',
          attr: 'color1'
        }, {
          name: 'color2',
          placeholder: '#fff',
          type: 'color',
          'default': '#fff6e6',
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
        var i$, i, begin;
        data = data.replace(/duration_2/g, opt.speed * 2 + "s");
        data = data.replace(/duration/g, opt.speed + "s");
        data = data.replace(/#000/g, opt.c1);
        data = data.replace(/#fff/g, opt.c2);
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        data = data.replace(/"uil-circle-css"/, "'uil-circle-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
        for (i$ = 8; i$ >= 1; --i$) {
          i = i$;
          begin = parseInt(((i - 1) * 2 * opt.speed / 8) * 100) / 100 + "s";
          data = data.replace(new RegExp("begin" + i, "g"), begin);
        }
        return data;
      },
      custom: function(s, e, a, c){
        a.$observe('color1', function(v){
          if (v) {
            return e.find("circle:nth-of-type(2n)").css('fill', v);
          }
        });
        a.$observe('color2', function(v){
          if (v) {
            return e.find("circle:nth-of-type(2n+1)").css('fill', v);
          }
        });
        return a.$observe('background', function(v){
          if (v) {
            return e.find('rect').css('fill', v);
          }
        });
      },
      start: function(s, e, a, c){},
      stop: function(s, e, a, c){},
      step: function(s, e, a, c, delay){
        var this$ = this;
        return e.find('circle').each(function(){
          var v;
          v = (7 - arguments[0]) * 15 - 30 * ((delay % 1000) / 1000);
          if (v < 0) {
            v = 0;
          }
          return $(arguments[1]).attr('r', v);
        });
      }
    };
  });
  return x$;
});
