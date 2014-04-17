<- define <[]>
angular.module \uiloading
  ..factory \uilType-poi, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \both
      radius: 15
      variant: 1
      vars: 
        * name: 'variant', placeholder: '', type: 'choice', default: \jump, values: <[jump rotate]>, attr: 'variant'
        * name: 'color', placeholder: '#f00', type: 'color', default: '#d51', attr: 'color'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /uil-poi-anim-type/g, "uil-poi-anim#{@variant}"
        data = data.replace /#000|black/g, "#{opt.c2}"
        data = data.replace /1s/g, "#{opt.speed}s"

        if @variant == 1 => data = data.replace /type="translate"/g, 'type="none"'
        if @variant == 0 =>
          data = data.replace /type="rotate"/, 'type="none"'
        data = uilresize data, \poi, opt
      custom: (s, e, a, c) ->
        a.$observe 'variant' (v) ~>
          @variant = switch v
          | \jump => 0
          | \rotate => 1
          e.find "path" .attr \transform, "translate(0,0)"
          e.find "svg > g > g" .attr \transform, "rotate(0)"
        a.$observe 'color' (v) -> if v => e.find \path .css \fill, v
        a.$observe 'background' (v) -> if v => e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        switch @variant
        | 0 =>
          <- e.find "path" .each
          v = ( (500 - ( delay % 1000 )) / 500 ) ** 2
          $(&1)attr \transform, "translate(0 #{-17 + v * 34})"
        | 1 =>
          <- e.find "svg > g > g" .each
          v = 360 * ( ( delay % 1000 ) / 1000 )
          $(&1)attr \transform, "rotate(#{v})"
