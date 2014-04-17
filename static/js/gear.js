define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-gear', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [{
        name: 'color',
        placeholder: '#000',
        type: 'color',
        'default': '#998660',
        attr: 'color'
      }],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/#000|black/g, opt.c1 + "");
        return data = uilresize(data, 'default', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('color', function(v){
          if (v) {
            return e.find('path').css('fill', v);
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
        var r;
        r = 90 * ((delay % 1000) / 1000);
        return e.find('path').each(function(){
          return $(arguments[1]).attr('transform', "rotate(" + r + " 50 50)");
        });
      }
    };
  });
  return x$;
});
