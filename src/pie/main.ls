<- define <[]>
angular.module \uiloading
  ..factory \uilType-pie, ($interval) ->
    start = null
    ret = do
      mode: \both
      speed: 5
      vars: 
        * name: 'color1', placeholder: '#920', type: 'color', default: '#920', attr: 'color1'
        * name: 'color2', placeholder: '#f90', type: 'color', default: '#f90', attr: 'color2'
        * name: 'color3', placeholder: '#2f4', type: 'color', default: '#2f4', attr: 'color3'
        * name: 'color4', placeholder: '#029', type: 'color', default: '#029', attr: 'color4'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) -> data
      custom: (s, e, a, c) ->
        a.$observe 'color1' (v) ~> if v =>
          e.find "path:nth-of-type(1)" .css \fill, v
        a.$observe 'color2' (v) -> if v =>
          e.find "path:nth-of-type(2)" .css \fill, v
        a.$observe 'color3' (v) -> if v =>
          e.find "path:nth-of-type(3)" .css \fill, v
        a.$observe 'color4' (v) -> if v =>
          e.find "path:nth-of-type(4)" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        v = ( delay % 1000 ) / 1000
        e.find \path .each ~>
          $(&1)attr \transform, "rotate(#{v * 360 * (4 - &0)} 50 50)"

