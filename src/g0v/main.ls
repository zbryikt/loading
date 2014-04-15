<- define <[]>
angular.module \uiloading
  ..factory \uilType-g0v, ($interval) ->
    start = null
    ret = do
      mode: \svg
      vars:
        [{ name: 'variant', placeholder: '', type: 'choice', values: <[rotate jump]>, attr: 'variant' }]
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /type1/g, if @variant == \rotate => "transform" else "none"
        data = data.replace /type2/g, if @variant == \jump => "transform" else "none"
      custom: (s, e, a, c) ->
        a.$observe 'variant' (v) ~> if v => @variant = v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        switch @variant
        | \rotate =>
          e.find ".uil-g0v > g" .attr \transform, "translate(0 0) rotate(#{360 * (delay % 1000) / 1000} 50 50)"
          e.find "g > g" .attr \transform, "scale(1.0 1.0)"
        | \jump =>
          v = (500 - (delay % 1000)) / 500
          t = v * v * 85
          r = v * v * v * v * 0.65
          e.find ".uil-g0v > g" .attr \transform, "translate(10 #t)"
          e.find "g > g" .attr \transform, "scale(0.8 #{0.8 - r})"
