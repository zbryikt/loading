<- define <[]>
angular.module \uiloading
  ..factory \uilType-wheel, ($interval) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        [{ name: 'color', placeholder: '#f00', type: 'color', default: '#000', attr: 'color' }]
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /#000|black/g, "#{opt.c1}"
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-wheel-css"/, "'uil-wheel-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) -> if v =>
          e.find \circle .css \stroke, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \circle .attr \stroke-dashoffset, 110 * ( delay % 1000 ) / 1000
