define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-ball', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      radius: 15,
      vars: [
        {
          name: 'color',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'color'
        }, {
          name: 'radius',
          placeholder: '15',
          type: 'px',
          'default': '15',
          attr: 'radius'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/#000|black/g, opt.c1 + "");
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/15/g, opt.c2 + "");
        data = data.replace(/ballRadius2/g, 4 * opt.c2 + "px");
        data = data.replace(/ballRadius/g, 2 * opt.c2 + "px");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        return data = data.replace(/"uil-ball-css"/, "'uil-ball-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
      },
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('color', function(v){
          if (v) {
            return e.find('circle').css('fill', v);
          }
        });
        a.$observe('radius', function(v){
          if (v) {
            this$.radius = v;
            return e.find('circle').attr('r', v);
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
        return e.find('circle').each(function(){
          var v;
          v = Math.pow((500 - delay % 1000) / 500, 2);
          return $(arguments[1]).attr('cy', (20 + v * 60) + "");
        });
      }
    };
  });
  return x$;
});
