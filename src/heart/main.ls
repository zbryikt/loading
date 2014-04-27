<- define <[]>
angular.module \uiloading
  ..factory \uilType-heart, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        [{ name: 'color', placeholder: '#f02', type: 'color', default: '#f02', attr: 'color' }]
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /color/g, opt.c1
        data = data.replace /1s/g, "#{opt.speed}s"
        data = uilresize data, \heart, opt
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) -> if v =>
          e.find "path" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find "svg > g > g" .each ~>
          v = ( delay % 1000 ) / 1000
          if v < 0.3 => v = 1.25 - 0.4 * ( (0.09 - (( 0.3 -  v ) ** 2)) / 0.09 )
          else v = 1.1 - 0.2 * ( (0.49 - (( 0.7 -  v ) ** 2)) / 0.49 )
          $(&1)attr \transform, "scale(#{v})"
