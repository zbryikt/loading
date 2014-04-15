define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-spin', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      speed: 1,
      vars: [
        {
          name: 'color',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'color'
        }, {
          name: 'radius',
          placeholder: '8',
          type: 'px',
          'default': '8',
          attr: 'radius'
        }, {
          name: 'scaling',
          placeholder: '',
          type: 'choice',
          values: ['all', 'x-axis', 'y-axis'],
          attr: 'scaling'
        }
      ],
      patchCss: function(data, opt){
        var s;
        s = (function(){
          switch (this.scaling) {
          case 0:
            return 'scale';
          case 1:
            return 'scaleY';
          case 2:
            return 'scaleX';
          }
        }.call(this));
        data = data.replace(/scale/g, s);
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        var ref$, s1, s2;
        ref$ = (function(){
          switch (this.scaling) {
          case 0:
            return ['1.4', '1.0'];
          case 1:
            return ['1.0,1.4', '1.0,1.0'];
          case 2:
            return ['1.4,1.0', '1.0,1.0'];
          }
        }.call(this)), s1 = ref$[0], s2 = ref$[1];
        data = data.replace(/maxs/g, s1);
        data = data.replace(/mins/g, s2);
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        var i$, i, begin;
        data = data.replace(/#000|black/g, opt.c1 + "");
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/svg width="100%" height="100%"/, "svg width='" + opt.size * 2 + "px' height='" + opt.size * 2 + "px'");
        data = data.replace(/"uil-spin-css"/, "'uil-spin-css' style='-webkit-transform:scale(" + opt.size * 2 / 200 + ")'");
        for (i$ = 8; i$ >= 1; --i$) {
          i = i$;
          begin = parseInt(((i - 1) * opt.speed / 8) * 100) / 100 + "s";
          data = data.replace(new RegExp("begin" + i, "g"), begin);
        }
        return data;
      },
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('color', function(v){
          if (v) {
            return e.find("circle").css('fill', v);
          }
        });
        a.$observe('radius', function(v){
          if (v) {
            return e.find("circle").attr('r', v);
          }
        });
        a.$observe('scaling', function(v){
          if (v) {
            return this$.scaling = v === 'x-axis'
              ? 1
              : v === 'y-axis' ? 2 : 0;
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
        return e.find('circle').each(function(){
          var v;
          v = ((delay + this$.speed * (7 - arguments[0]) * 1000 / 8) % 1000) / 1000;
          $(arguments[1]).attr('opacity', 1 - v * 0.9);
          switch (this$.scaling) {
          case 0:
            return $(arguments[1]).attr('transform', "scale(" + (1.4 - v * 0.4) + ")");
          case 1:
            return $(arguments[1]).attr('transform', "scale(1," + (1.4 - v * 0.4) + ")");
          case 2:
            return $(arguments[1]).attr('transform', "scale(" + (1.4 - v * 0.4) + ",1)");
          }
        });
      }
    };
  });
  return x$;
});
