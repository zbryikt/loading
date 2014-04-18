define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-ellipsis', function($interval, uilresize){
    var offset, ani, start, ret;
    offset = [0, 250, 500, 750];
    ani = {
      r: [0, 1, 1, 1, 1, 1, 1, 0],
      x: [15, 15, 15, 50, 50, 85, 85, 85]
    };
    start = null;
    return ret = {
      mode: 'both',
      circleRadius: 15,
      vars: [
        {
          name: 'color1',
          placeholder: '#000',
          type: 'color',
          'default': '#403d3d',
          attr: 'color1'
        }, {
          name: 'color2',
          placeholder: '#000',
          type: 'color',
          'default': '#808a80',
          attr: 'color2'
        }, {
          name: 'circle radius',
          placeholder: '15',
          type: 'px',
          'default': '15',
          attr: 'circle-radius'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = uilresize(data, 'ellipsis', opt);
        data = data.replace(/circleColor1/g, opt.c1);
        data = data.replace(/circleColor2/g, opt.c2);
        data = data.replace(/15/g, opt.c3);
        data = data.replace(/circleRadius2/g, opt.c3 * 4 + "px");
        data = data.replace(/circleRadius/g, opt.c3 * 2 + "px");
        data = data.replace(/circleMargin/g, (30 - opt.c3 * 2) + "px");
        data = data.replace(/duration/g, opt.speed + "s");
        data = data.replace(/s?1-8s/g, 1 * opt.speed / 8 + "s");
        data = data.replace(/s?2-8s/g, 2 * opt.speed / 8 + "s");
        data = data.replace(/s?3-8s/g, 3 * opt.speed / 8 + "s");
        data = data.replace(/s?4-8s/g, 4 * opt.speed / 8 + "s");
        data = data.replace(/s?5-8s/g, 5 * opt.speed / 8 + "s");
        data = data.replace(/s?6-8s/g, 6 * opt.speed / 8 + "s");
        return data;
      },
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('color1', function(v){
          if (v) {
            return e.find("circle:nth-of-type(2n+1)").css('fill', v);
          }
        });
        a.$observe('color2', function(v){
          if (v) {
            return e.find("circle:nth-of-type(2n)").css('fill', v);
          }
        });
        a.$observe('circleRadius', function(v){
          if (v) {
            e.find('circle').attr('r', v);
            return this$.circleRadius = parseInt(v);
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
          var p, q, d, r, x;
          p = parseInt((delay % 1000) / 125);
          p = (p + arguments[0] * 2) % 8;
          q = (p + 1) % 8;
          d = delay % 125;
          r = (d / 125) * (ani.r[q] - ani.r[p]) + ani.r[p];
          x = (d / 125) * (ani.x[q] - ani.x[p]) + ani.x[p];
          $(arguments[1]).attr('r', r * this$.circleRadius);
          return $(arguments[1]).attr('cx', x);
        });
      }
    };
  });
  return x$;
});
