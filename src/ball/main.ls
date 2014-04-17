<- define <[]>
angular.module \uiloading
  ..factory \uilType-ball, ($interval) ->
    start = null
    ret = do
      mode: \both
      radius: 15
      variant: 1
      vars: 
        * name: 'variant', placeholder: '', type: 'choice', default: \jump, values: <[jump rotate]>, attr: 'variant'
        * name: 'color', placeholder: '#b00', type: 'color', default: '#b10000', attr: 'color'
        * name: 'radius', placeholder: '15', type: 'px', default: '15', attr: 'radius'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /uil-ball-anim-type/g, "uil-ball-anim#{@variant}"
        data = data.replace /#000|black/g, "#{opt.c2}"
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /15/g, "#{opt.c3}"
        data = data.replace /ballRadius2/g, "#{4 * opt.c3}px"
        data = data.replace /ballRadius/g, "#{2 * opt.c3}px"

        if @variant == 1 => data = data.replace /attributeName="cy"/, ""
        if @variant == 0 =>
          data = data.replace /attributeName="transform"/, ""
          data = data.replace /translate\(30 0\)/, ""

        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-ball-css"/, "'uil-ball-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
      custom: (s, e, a, c) ->
        a.$observe 'variant' (v) ~>
          @variant = switch v
          | \jump => 0
          | \rotate => 1
          | \rubberband => 2
          e.find \circle
            .attr \transform, if @variant == 1 => "translate(30 0)" else "translate(0 0)"
            .attr \cy, 0
          e.find "g > g" .attr \transform, "rotate(0)"
        a.$observe 'color' (v) -> if v => e.find \circle .css \fill, v
        a.$observe 'radius' (v) ~> if v => 
          @radius = v
          e.find \circle .attr \r, v
        a.$observe 'background' (v) -> if v => e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        switch @variant
        | 0 =>
          <- e.find \circle .each
          v = ( (500 - ( delay % 1000 )) / 500 ) ** 2
          $(&1)attr \cy, "#{-30 + v * 60}"
        | 1 =>
          <- e.find "g > g" .each
          v = 360 * ( ( delay % 1000 ) / 1000 )
          $(&1)attr \transform, "rotate(#{v})"
