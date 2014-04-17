define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-gears', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [
        {
          name: 'color1',
          placeholder: '#000',
          type: 'color',
          'default': '#8f7f59',
          attr: 'color1'
        }, {
          name: 'color2',
          placeholder: '#000',
          type: 'color',
          'default': '#9f9fab',
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
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/#000|black/g, opt.c1 + "");
        data = data.replace(/#999/g, opt.c2 + "");
        return data = uilresize(data, 'gears', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('color1', function(v){
          if (v) {
            return e.find("g:nth-of-type(1) > path").css('fill', v);
          }
        });
        a.$observe('color2', function(v){
          if (v) {
            return e.find("g:nth-of-type(2) > path").css('fill', v);
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
          var r;
          r = 90 * ((delay % 1000) / 1000);
          if (arguments[0] === 0) {
            r = 90 - r;
          }
          return $(arguments[1]).attr('transform', "rotate(" + r + " 50 50)");
        });
      }
    };
  });
  return x$;
});
