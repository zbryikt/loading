define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-hourglass', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'svg',
      vars: [
        {
          name: 'glass color',
          placeholder: '#000',
          type: 'color',
          'default': '#007282',
          attr: 'glass-color'
        }, {
          name: 'sand color',
          placeholder: '#000',
          type: 'color',
          'default': '#ffab00',
          attr: 'sand-color'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        data = data.replace(/glassColor/g, opt.c1);
        data = data.replace(/sandColor/g, opt.c2);
        data = data.replace(/1s/g, opt.speed + "s");
        return data = uilresize(data, 'hourglass', opt);
      },
      custom: function(s, e, a, c){
        a.$observe('glassColor', function(v){
          if (v) {
            return e.find("path.glass").css('stroke', v);
          }
        });
        a.$observe('sandColor', function(v){
          if (v) {
            return e.find("path.sand").css('fill', v);
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
        var v, u, ref$, this$ = this;
        v = ((delay % 1000) / 1000) * 1.5;
        u = v < 1 ? v : 1;
        e.find('#uil-hourglass-clip1 rect.clip').each(function(){
          return $(arguments[1]).attr({
            height: (25 - 25 * u) + "px",
            y: (20 + 25 * u) + "px"
          });
        });
        e.find('#uil-hourglass-clip2 rect.clip').each(function(){
          return $(arguments[1]).attr({
            height: 25 * u + "px",
            y: (55 + 25 - 25 * u) + "px"
          });
        });
        u = (ref$ = v - 1) > 0 ? ref$ : 0;
        return e.find('g').each(function(){
          return $(arguments[1]).attr('transform', "rotate(" + 360 * u + " 50 50)");
        });
      }
    };
  });
  return x$;
});
