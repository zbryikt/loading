define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-squares', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [
        {
          name: 'dark color',
          placeholder: '#000',
          type: 'color',
          'default': '#047ab3',
          attr: 'dark-color'
        }, {
          name: 'light color',
          placeholder: '#000',
          type: 'color',
          'default': '#00cde8',
          attr: 'light-color'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/darkColor/g, opt.c1);
        data = data.replace(/lightColor/g, opt.c2);
        data = data.replace(/1s/g, opt.speed + "s");
        data = data.replace(/s18/g, 0 * opt.speed / 8 + "s");
        data = data.replace(/s28/g, 1 * opt.speed / 8 + "s");
        data = data.replace(/s38/g, 2 * opt.speed / 8 + "s");
        data = data.replace(/s48/g, 3 * opt.speed / 8 + "s");
        data = data.replace(/s58/g, 4 * opt.speed / 8 + "s");
        data = data.replace(/s68/g, 5 * opt.speed / 8 + "s");
        data = data.replace(/s78/g, 6 * opt.speed / 8 + "s");
        data = data.replace(/s88/g, 7 * opt.speed / 8 + "s");
        return data = uilresize(data, 'squares', opt);
      },
      darkColor: '#000',
      lightColor: '#999',
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('darkColor', function(v){
          if (v) {
            this$.darkColor = v;
            return this$.color = d3.scale.linear().domain([0, 1]).range([this$.lightColor, this$.darkColor]);
          }
        });
        a.$observe('lightColor', function(v){
          if (v) {
            this$.lightColor = v;
            return this$.color = d3.scale.linear().domain([0, 1]).range([this$.lightColor, this$.darkColor]);
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
      color: d3.scale.linear().domain([0, 1]).range(['#999', '#000']),
      step: function(s, e, a, c, delay){
        var this$ = this;
        return e.find('rect.sq').each(function(){
          var v, ref$, ref1$;
          v = ((ref$ = (ref1$ = (1000 - arguments[0] * 125 + delay) % 1000 - 100) > 0 ? ref1$ : 0) < 100 ? ref$ : 100) / 100;
          return $(arguments[1]).attr('fill', this$.color(v));
        });
      }
    };
  });
  return x$;
});
