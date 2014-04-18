define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-spin', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      speed: 1,
      ratio: 0.6,
      radius: 8,
      vars: [
        {
          name: 'color',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'color'
        }, {
          name: 'radius',
          placeholder: '6',
          type: 'px',
          'default': '6',
          attr: 'radius'
        }, {
          name: 'ratio',
          placeholder: '5',
          type: 'px',
          'default': '5',
          attr: 'ratio'
        }, {
          name: 'scaling',
          placeholder: '',
          type: 'choice',
          'default': 'all',
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
        data = data.replace(/1\.4/g, (1 + this.ratio) + "");
        data = data.replace(/32px/g, (this.radius || 8) * 4 + "px");
        data = data.replace(/mgn/g, (16 - (this.radius || 8) * 2) + "px");
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        var sr, ref$, s1, s2;
        sr = 1.0 + this.ratio;
        ref$ = (function(){
          switch (this.scaling) {
          case 0:
            return [sr, 1.0];
          case 1:
            return ["1.0," + sr, "1.0,1.0"];
          case 2:
            return [sr + ",1.0", "1.0,1.0"];
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
        a.$observe('ratio', function(v){
          var ref$;
          if (v) {
            return this$.ratio = ((ref$ = v > 0 ? v : 0) < 20 ? ref$ : 20) / 10.0;
          }
        });
        a.$observe('color', function(v){
          if (v) {
            return e.find("circle").css('fill', v);
          }
        });
        a.$observe('radius', function(v){
          if (v) {
            this$.radius = v;
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
            return $(arguments[1]).attr('transform', "scale(" + (1.0 + this$.ratio - v * this$.ratio) + ")");
          case 1:
            return $(arguments[1]).attr('transform', "scale(1," + (1.0 + this$.ratio - v * this$.ratio) + ")");
          case 2:
            return $(arguments[1]).attr('transform', "scale(" + (1.0 + this$.ratio - v * this$.ratio) + ",1)");
          }
        });
      }
    };
  });
  return x$;
});
