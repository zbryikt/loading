define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-dashinfinity', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [
        {
          name: 'line color',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'line-color'
        }, {
          name: 'dash length',
          placeholder: '5',
          type: 'px',
          'default': '5',
          attr: 'dash-length'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/#000/g, opt.c1 + "");
        data = data.replace(/stroke-dasharray="5"/g, "stroke-dasharray='" + opt.c2 + "'");
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        console.log(data);
        return data;
      },
      custom: function(s, e, a, c){
        a.$observe('lineColor', function(v){
          if (v) {
            return e.find('path').css('stroke', v);
          }
        });
        a.$observe('dashLength', function(v){
          if (v) {
            return e.find('path').css('stroke-dasharray', v);
          }
        });
        return a.$observe('background', function(v){
          if (v) {
            return e.find('rect').css('fill', v);
          }
        });
      },
      start: function(s, e, a, c){
        this.path = e.find('path')[0];
        if (this.path) {
          return this.length = this.path.getTotalLength();
        }
      },
      stop: function(s, e, a, c){},
      step: function(s, e, a, c, delay){
        if (!this.path) {
          this.start(s, e, a, c);
        }
        if (!this.path) {
          return;
        }
        return e.find('path').css("stroke-dashoffset", this.length * (delay % 1000) / 1000);
      }
    };
  });
  return x$;
});
