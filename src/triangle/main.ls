<- define <[]>
angular.module \uiloading
  ..factory \uilType-triangle, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'color1', placeholder: '#000', type: 'color', default: '#ffdb00', attr: 'color1'
        * name: 'color2', placeholder: '#000', type: 'color', default: '#ffdb00', attr: 'color2'
        * name: 'color3', placeholder: '#000', type: 'color', default: '#ffdb00', attr: 'color3'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /color1/g, opt.c1
        data = data.replace /color2/g, opt.c2
        data = data.replace /color3/g, opt.c3
        data = data.replace /1s/g, "#{opt.speed}s"
        data = uilresize data, \triangle, opt
      custom: (s, e, a, c) ->
        a.$observe 'color1' (v) -> if v =>
          e.find "path:nth-of-type(1)" .css \fill, v
        a.$observe 'color2' (v) -> if v =>
          e.find "path:nth-of-type(2)" .css \fill, v
        a.$observe 'color3' (v) -> if v =>
          e.find "path:nth-of-type(3)" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      rotate: (idx, v) -> 
        switch idx
        | 0 => "rotate(#v 33 35)"
        | 1 => "rotate(#v 67 35)"
        | 2 => "rotate(#v 50 65)"
      step: (s, e, a, c, delay) ->
        e.find \path .each ~>
          v = 120 * ( ( delay ) % 1000 ) / 1000
          $(&1)attr \transform, @rotate(&0, v)
          
