<- define <[]>
angular.module \uiloading
  ..factory \uilType-hourglass, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        * name: 'glass color', placeholder: '#000', type: 'color', default: '#007282', attr: 'glass-color'
        * name: 'sand color', placeholder: '#000', type: 'color', default: '#ffab00', attr: 'sand-color'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /glassColor/g, opt.c1
        data = data.replace /sandColor/g, opt.c2
        data = data.replace /1s/g, "#{opt.speed}s"
        data = uilresize data, \hourglass, opt
      custom: (s, e, a, c) ->
        a.$observe 'glassColor' (v) -> if v =>
          e.find "path.glass" .css \stroke, v
        a.$observe 'sandColor' (v) -> if v =>
          e.find "path.sand" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        v = ((delay % 1000) / 1000) * 1.5
        u = v <? 1
        e.find '#uil-hourglass-clip1 rect.clip' .each ~>
          $(&1)attr do
            height: "#{25 - 25 * u}px"
            y: "#{20 + 25 * u}px"
        e.find '#uil-hourglass-clip2 rect.clip' .each ~>
          $(&1)attr do
            height: "#{25 * u}px"
            y: "#{55 + 25 - 25 * u}px"
        u = v - 1 >? 0
        e.find \g .each ~>
          $(&1)attr \transform, "rotate(#{360 * u} 50 50)"
