<- define <[]>
angular.module \uiloading
  ..factory \uilType-magnify, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'body color', placeholder: '#f00', type: 'color', default: '#424242', attr: 'body-color'
        * name: 'glass color', placeholder: '#f00', type: 'color', default: '#8b8bfc', attr: 'glass-color'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /bodyColor/g, opt.c1
        data = data.replace /glassColor/g, opt.c2
        data = data.replace /duration/g, "#{opt.speed}s"
        data = uilresize data, \magnify, opt
      custom: (s, e, a, c) ->
        a.$observe 'bodyColor' (v) -> if v =>
          e.find "path" .css \fill, v
        a.$observe 'glassColor' (v) -> if v =>
          e.find "circle" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      ctrlptr: [[15,15], [-15, 15], [0,-10.98] [15,15]]    
      step: (s, e, a, c, delay) ->
        e.find \g .each ~>
          v = ( delay % 1000 ) / 1000
          d = parseInt( v / 0.333 )
          [x, y] = @ctrlptr[d]
          dx = @ctrlptr[d + 1][0] - @ctrlptr[d][0]
          dy = @ctrlptr[d + 1][1] - @ctrlptr[d][1]
          x = x + dx * ( v - d * 0.333 ) / 0.333
          y = y + dy * ( v - d * 0.333 ) / 0.333
          $(&1)attr \transform, "translate(#x #y)"
