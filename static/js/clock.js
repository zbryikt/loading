define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-clock', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      speed: 5,
      mode: 'both',
      vars: [
        {
          name: 'circle color',
          placeholder: '#000',
          type: 'color',
          'default': '#2b74ba',
          attr: 'circle-color'
        }, {
          name: 'clock color',
          placeholder: '#000',
          type: 'color',
          'default': '#d6f1ff',
          attr: 'clock-color'
        }, {
          name: 'line color1',
          placeholder: '#000',
          type: 'color',
          'default': '#000',
          attr: 'line-color1'
        }, {
          name: 'line color2',
          placeholder: '#f00',
          type: 'color',
          'default': '#f00',
          attr: 'line-color2'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/circleColor/g, opt.c1);
        data = data.replace(/clockColor/g, opt.c2);
        data = data.replace(/lineColor1/g, opt.c3);
        data = data.replace(/lineColor2/g, opt.c4);
        data = data.replace(/duration1/g, opt.speed / 5 + "s");
        data = data.replace(/duration2/g, opt.speed + "s");
        return data = uilresize(data, 'clock', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('circleColor', function(v){
          if (v) {
            return e.find("circle").css('stroke', v);
          }
        });
        a.$observe('clockColor', function(v){
          if (v) {
            return e.find("circle").css('fill', v);
          }
        });
        a.$observe('lineColor1', function(v){
          if (v) {
            return e.find("line:nth-of-type(1)").css('stroke', v);
          }
        });
        a.$observe('lineColor2', function(v){
          if (v) {
            return e.find("line:nth-of-type(2)").css('stroke', v);
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
        return e.find('line').each(function(){
          var v;
          v = 360 * 5 * (delay % 1000) / 1000;
          if (arguments[0] === 0) {
            v /= 5;
          }
          return $(arguments[1]).attr('transform', "rotate(" + v + " 50 50)");
        });
      }
    };
  });
  return x$;
});
