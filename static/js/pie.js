define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-pie', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      speed: 5,
      vars: [
        {
          name: 'color1',
          placeholder: '#920',
          type: 'color',
          'default': '#920',
          attr: 'color1'
        }, {
          name: 'color2',
          placeholder: '#f90',
          type: 'color',
          'default': '#f90',
          attr: 'color2'
        }, {
          name: 'color3',
          placeholder: '#2f4',
          type: 'color',
          'default': '#2f4',
          attr: 'color3'
        }, {
          name: 'color4',
          placeholder: '#029',
          type: 'color',
          'default': '#029',
          attr: 'color4'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        return data;
      },
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('color1', function(v){
          if (v) {
            return e.find("path:nth-of-type(1)").css('fill', v);
          }
        });
        a.$observe('color2', function(v){
          if (v) {
            return e.find("path:nth-of-type(2)").css('fill', v);
          }
        });
        a.$observe('color3', function(v){
          if (v) {
            return e.find("path:nth-of-type(3)").css('fill', v);
          }
        });
        a.$observe('color4', function(v){
          if (v) {
            return e.find("path:nth-of-type(4)").css('fill', v);
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
        var v, this$ = this;
        v = (delay % 1000) / 1000;
        return e.find('path').each(function(){
          return $(arguments[1]).attr('transform', "rotate(" + v * 360 * (4 - arguments[0]) + " 50 50)");
        });
      }
    };
  });
  return x$;
});
