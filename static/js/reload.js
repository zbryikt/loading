define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-reload', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [{
        name: 'color',
        placeholder: '#f00',
        type: 'color',
        'default': '#2fc296',
        attr: 'color'
      }],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/#000|black/g, opt.c1 + "");
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        return data = data.replace(/"uil-reload-css"/, "'uil-reload-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
      },
      custom: function(s, e, a, c){
        a.$observe('color', function(v){
          if (v) {
            return e.find('path').each(function(){
              if (arguments[0] === 0) {
                $(arguments[1]).css('stroke', v);
              }
              if (arguments[0] === 1) {
                return $(arguments[1]).css('fill', v);
              }
            });
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
        return e.find('g').attr('transform', "rotate(" + 360 * (delay % 1000) / 1000 + " 50 50)");
      }
    };
  });
  return x$;
});
