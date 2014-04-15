define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-pacman', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      angle: 30,
      vars: [
        {
          name: 'color',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'color'
        }, {
          name: 'angle',
          placeholder: '#f00',
          type: 'px',
          'default': '30',
          attr: 'angle'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/#000|black/g, opt.c1 + "");
        data = data.replace(/30deg/g, opt.c2 + "deg");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        return data = data.replace(/"uil-pacman-css"/, "'uil-pacman-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
      },
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('color', function(v){
          if (v) {
            return e.find('path').css('fill', v);
          }
        });
        a.$observe('angle', function(v){
          if (v && !isNaN(v)) {
            return this$.angle = parseInt(v);
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
        return e.find('path').each(function(){
          var r;
          r = Math.abs(this$.angle * 2 * (500 - delay % 1000) / 1000);
          return $(arguments[1]).attr('transform', "rotate(" + (arguments[0] ? -1 : 1) * r + " 50 50)");
        });
      }
    };
  });
  return x$;
});
