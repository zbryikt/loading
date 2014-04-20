<- define <[]>
angular.module \uiloading
  ..factory \uilType-spiral, ($interval,uilresize) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        [{ name: 'spiral color', placeholder: '#f00', type: 'color', default: '#f00', attr: 'spiral-color' }]
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /spiralColor/g, opt.c1
        data = data.replace /1s/g, "#{opt.speed}s"
        data = uilresize data, \spiral, opt
      custom: (s, e, a, c) ->
        a.$observe 'spiralColor' (v) -> if v =>
          e.find "path" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \path .each ~>
          v = 360 * ( ( delay % 1000 ) / 1000 )
          $(&1)attr \transform, "rotate(#v 50 50)"
