define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-infinity', function($interval){
    var offset, ret;
    offset = [0, 100, 200, 300, 400];
    return ret = {
      mode: 'svg',
      vars: [
        {
          name: 'circle color',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'circle-color'
        }, {
          name: 'line color',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'line-color'
        }
      ],
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        var i$, i, begin;
        data = data.replace(/circleColor/g, opt.c1);
        data = data.replace(/lineColor/g, opt.c2);
        data = data.replace(/duration/g, opt.speed + "s");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        for (i$ = 5; i$ >= 1; --i$) {
          i = i$;
          begin = parseInt(((i - 1) * opt.speed / 12) * 100) / 100 + "s";
          data = data.replace(new RegExp("begin" + i, "g"), begin);
        }
        return data;
      },
      custom: function(s, e, a, c){
        a.$observe('circleColor', function(v){
          if (v) {
            return e.find('circle').css('fill', v);
          }
        });
        a.$observe('lineColor', function(v){
          if (v) {
            return e.find('path').css('stroke', v);
          }
        });
        return a.$observe('background', function(v){
          if (v) {
            return e.find('rect').css('fill', v);
          }
        });
      },
      start: function(s, e, a, c){
        this.path = document.getElementById("uil-inf-path");
        if (this.path) {
          return this.length = this.path.getTotalLength();
        }
      },
      stop: function(s, e, a, c){},
      step: function(s, e, a, c, delay){
        var this$ = this;
        if (!this.path) {
          this.start(s, e, a, c);
        }
        return e.find('circle').each(function(){
          var ptr;
          ptr = this$.path.getPointAtLength(this$.length * parseFloat(((delay + offset[arguments[0]]) % 1000) / 1000.0));
          $(arguments[1]).attr('cx', ptr.x);
          return $(arguments[1]).attr('cy', ptr.y);
        });
      }
    };
  });
  return x$;
});
