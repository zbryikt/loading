<- define <[]>
angular.module \uiloading
  ..factory \uilType-gear, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        [{ name: 'color', placeholder: '#000', type: 'color', default: '#998660', attr: 'color' }]
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /#000|black/g, "#{opt.c1}s"
        data = uilresize data, \default, opt
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) -> if v => e.find \path .css \fill, v
        a.$observe 'background' (v) -> if v => e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        r = 360 * (( delay % 1000 ) / 1000)
        e.find \path .each ->
          $(&1)attr \transform, "rotate(#r 50 50)"
