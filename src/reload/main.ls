<- define <[]>
angular.module \uiloading
  ..factory \uilType-reload, ($interval) ->
    start = null
    ret = do
      mode: \both
      vars: 
        [{ name: 'color', placeholder: '#f00', type: 'color', default: '#000', attr: 'color' }]
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /#000|black/g, "#{opt.c1}"
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-reload-css"/, "'uil-reload-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) -> if v =>
          e.find \path .each ->
            if &0==0 => $(&1)css \stroke, v
            if &0==1 => $(&1)css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \g .attr \transform, "rotate(#{360 * ( delay % 1000 ) / 1000} 50 50)"

