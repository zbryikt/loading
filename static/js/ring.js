define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-ring', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [{
        name: 'ring color',
        placeholder: '#000',
        type: 'color',
        'default': '#59ebff',
        attr: 'color'
      }],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/ringColor/g, opt.c1);
        data = data.replace(/1s/g, opt.speed + "s");
        return data = uilresize(data, 'ring', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('color', function(v){
          if (v) {
            return e.find("path").css('fill', v);
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
        return e.find('path').each(function(){
          var v;
          v = 360 * ((delay % 1000) / 1000);
          return $(arguments[1]).attr('transform', "rotate(" + v + " 50 50)");
        });
      }
    };
  });
  return x$;
});
