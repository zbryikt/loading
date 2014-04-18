define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-wave', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      speed: 1,
      speedRate: [1, 1],
      vars: [
        {
          name: 'outer color',
          placeholder: '#000',
          type: 'color',
          'default': '#c123cf',
          attr: 'outer-color'
        }, {
          name: 'outer speed rate',
          placeholder: '1',
          type: 'px',
          'default': '1',
          attr: 'outer-speed'
        }, {
          name: 'inner color',
          placeholder: '#fff',
          type: 'color',
          'default': '#fdff8c',
          attr: 'inner-color'
        }, {
          name: 'inner speed rate',
          placeholder: '1',
          type: 'px',
          'default': '1',
          attr: 'inner-speed'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/outerColor/g, opt.c1);
        data = data.replace(/innerColor/g, opt.c3);
        data = data.replace(/outerSpeed/g, opt.c2 * this.speed);
        data = data.replace(/innerSpeed/g, opt.c4 * this.speed);
        data = uilresize(data, 'wave', opt);
        return data;
      },
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('outerColor', function(v){
          if (v) {
            return e.find("path:nth-of-type(1)").css('fill', v);
          }
        });
        a.$observe('innerColor', function(v){
          if (v) {
            return e.find("path:nth-of-type(2)").css('fill', v);
          }
        });
        a.$observe('outerSpeed', function(v){
          var ref$;
          if (v) {
            return this$.speedRate[0] = parseInt((ref$ = v > 1 ? v : 1) < 10 ? ref$ : 10);
          }
        });
        a.$observe('innerSpeed', function(v){
          var ref$;
          if (v) {
            return this$.speedRate[1] = parseInt((ref$ = v > 1 ? v : 1) < 10 ? ref$ : 10);
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
          var v;
          v = this$.speedRate[arguments[0]] * (arguments[0] * 2 - 1) * -45 * (delay % 1000) / 1000;
          return $(arguments[1]).attr('transform', "rotate(" + v + " 50 50)");
        });
      }
    };
  });
  return x$;
});
