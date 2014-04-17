<- define <[]>
angular.module \uiloading
  ..factory \uilType-gears, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        * name: 'color1', placeholder: '#000', type: 'color', default: '#8f7f59', attr: 'color1'
        * name: 'color2', placeholder: '#000', type: 'color', default: '#9f9fab', attr: 'color2'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /#000|black/g, "#{opt.c1}"
        data = data.replace /#999/g, "#{opt.c2}"
        data = uilresize data, \gears, opt
      custom: (s, e, a, c) ->
        a.$observe 'color1' (v) -> if v => e.find "g:nth-of-type(1) > path" .css \fill, v
        a.$observe 'color2' (v) -> if v => e.find "g:nth-of-type(2) > path" .css \fill, v
        a.$observe 'background' (v) -> if v => e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \path .each ~>
          r = 90 * ( ( delay % 1000 ) / 1000 )
          if &0 == 0 => r = 90 - r
          $(&1)attr \transform, "rotate(#{r} 50 50)"
