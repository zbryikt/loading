<- define <[]>
angular.module \uiloading
  ..factory \uilType-battery, ($interval,uilresize) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'outer color', placeholder: '#000', type: 'color', default: '#10004f', attr: 'outer-color'
        * name: 'inner color', placeholder: '#0f0', type: 'color', default: '#00e62c', attr: 'inner-color'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /outerColor/g, opt.c1
        data = data.replace /innerColor/g, opt.c2
        data = data.replace /1s/g, "#{opt.speed}s"
        data = uilresize data, \battery, opt
        data
      custom: (s, e, a, c) ->
        a.$observe 'outerColor' (v) -> if v => e.find "path" .css \fill, v
        a.$observe 'innerColor' (v) -> if v => e.find "rect.cell" .css \fill, v
        a.$observe 'background' (v) -> if v => e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \rect.cell .each ~>
          v = ( delay % 1000 ) / 1000
          v = (( v - (&0 * 0.2 + 0.1) >?0) / 0.2) <? 1
          $(&1)attr \opacity, v
