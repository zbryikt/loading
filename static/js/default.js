define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-default', function($interval, uilresize){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      count: 12,
      width: 7,
      height: 20,
      radius: 5,
      offset: 30,
      color: '#00b2ff',
      speed: 1,
      vars: [
        {
          name: 'color',
          placeholder: '#000',
          type: 'color',
          'default': '#00b2ff',
          attr: 'color'
        }, {
          name: 'count',
          placeholder: '12',
          type: 'px',
          'default': '12',
          attr: 'count'
        }, {
          name: 'width',
          placeholder: '7',
          type: 'px',
          'default': '7',
          attr: 'width'
        }, {
          name: 'height',
          placeholder: '20',
          type: 'px',
          'default': '20',
          attr: 'height'
        }, {
          name: 'radius',
          placeholder: '5',
          type: 'px',
          'default': '5',
          attr: 'radius'
        }, {
          name: 'offset',
          placeholder: '30',
          type: 'px',
          'default': '30',
          attr: 'offset'
        }
      ],
      patchSvg: function(data, opt){
        var svgHead, svg, i$, to$, i;
        svgHead = '<svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" ' + 'viewBox="0 0 100 100" preserveAspectRatio="xMidYMid" class="uil-default">' + '<rect x="0" y="0" width="100" height="100" fill="none" class="bk"></rect>';
        svg = "";
        for (i$ = 0, to$ = this.count; i$ < to$; ++i$) {
          i = i$;
          svg += "<rect " + (" x='" + (50 - this.width / 2) + "' y='" + (50 - this.height / 2) + "'") + (" width='" + this.width + "' height='" + this.height + "'") + (" rx='" + this.radius + "' ry='" + this.radius + "'") + (" fill='" + this.color + "'") + (" transform='rotate(" + 360 * i / this.count + " 50 50) translate(0 -" + this.offset + ")'>") + ("  <animate attributeName='opacity' from='1' to='0' dur='" + opt.speed + "s'") + (" begin='" + i * opt.speed / this.count + "s' repeatCount='indefinite'/>") + "</rect>";
        }
        svg = svgHead + svg + "</svg>";
        return svg = uilresize(svg, 'default', opt);
      },
      patchCss: function(data, opt){
        var ref$, html, css, keyframes, speed, animationValue, i$, to$, i, transform, style, oneCss;
        ref$ = ["", ""], html = ref$[0], css = ref$[1];
        keyframes = "{ 0% { opacity: 1} 100% {opacity: 0} }";
        speed = opt.speed;
        animationValue = "uil-default-anim " + speed + "s linear infinite";
        css = ("@-webkit-keyframes uil-default-anim " + keyframes) + ("@keyframes uil-default-anim " + keyframes);
        for (i$ = 0, to$ = this.count; i$ < to$; ++i$) {
          i = i$;
          transform = "rotate(" + parseInt(360 * i / this.count) + "deg) translate(0,-" + this.offset * 2 + "px)";
          style = ("top:" + (100 - this.height) + "px;left:" + (100 - this.width) + "px;width:" + this.width * 2 + "px;height:" + this.height * 2 + "px;") + ("background:" + this.color + ";-webkit-transform:" + transform + ";transform:" + transform + ";") + ("border-radius:" + this.radius * 2 + "px;");
          oneCss = (".uil-default-css > div:nth-of-type(" + (i + 1) + "){") + ("-webkit-animation: " + animationValue + ";") + ("animation: " + animationValue + ";") + ("-webkit-animation-delay: " + (i * speed / this.count - speed / 2) + "s;") + ("animation-delay: " + (i * speed / this.count - speed / 2) + "s;") + "}";
          css += oneCss;
          html += "<div style='" + style + "'></div>";
        }
        html = "<style type='text/css'>" + css + "</style><div class=\"uil-default-css\">" + html + "</div>";
        return html = uilresize(html, 'default', opt);
      },
      render: function(s, e, a, c, opt){
        var svg, x$, i, this$ = this;
        import$(this, opt);
        svg = d3.select(e[0]).select('svg');
        x$ = svg.selectAll('rect.bar').data((function(){
          var i$, to$, results$ = [];
          for (i$ = 0, to$ = this.count; i$ < to$; ++i$) {
            i = i$;
            results$.push(i * 360 / this.count);
          }
          return results$;
        }.call(this)));
        x$.exit().remove();
        x$.enter().append('rect').attr('class', 'bar');
        return svg.selectAll('rect.bar').attr({
          x: (50 - this.width / 2) + "",
          y: (50 - this.height / 2) + "",
          width: this.width,
          height: this.height,
          fill: this.color,
          rx: this.radius,
          ry: this.radius,
          transform: function(d, i){
            return "rotate(" + 360 * i / this$.count + " 50 50) translate(0 -" + this$.offset + ")";
          }
        });
      },
      custom: function(s, e, a, c){
        var this$ = this;
        a.$observe('color', function(v){
          if (v) {
            return this$.render(s, e, a, c, {
              color: v
            });
          }
        });
        a.$observe('count', function(v){
          if (v) {
            return this$.render(s, e, a, c, {
              count: v
            });
          }
        });
        a.$observe('width', function(v){
          if (v) {
            return this$.render(s, e, a, c, {
              width: v
            });
          }
        });
        a.$observe('height', function(v){
          if (v) {
            return this$.render(s, e, a, c, {
              height: v
            });
          }
        });
        a.$observe('radius', function(v){
          if (v) {
            return this$.render(s, e, a, c, {
              radius: v
            });
          }
        });
        return a.$observe('offset', function(v){
          if (v) {
            return this$.render(s, e, a, c, {
              offset: v
            });
          }
        });
      },
      start: function(s, e, a, c){},
      stop: function(s, e, a, c){},
      step: function(s, e, a, c, delay){
        var v, this$ = this;
        v = (delay % 1000) / 1000;
        return e.find('rect.bar').each(function(){
          var v;
          v = ((delay + (this$.count - arguments[0] - 1) * 1000 / this$.count) % 1000) / 1000;
          return $(arguments[1]).attr('opacity', v);
        });
      }
    };
  });
  return x$;
});
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}
