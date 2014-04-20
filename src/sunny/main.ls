<- define <[]>
angular.module \uiloading
  ..factory \uilType-sunny, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \both
      speed: 1
      vars: 
        * name: 'circle color', placeholder: '#000', type: 'color', default: '#edb900', attr: 'circle-color'
        * name: 'light color', placeholder: '#000', type: 'color', default: '#ff0000', attr: 'light-color'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /circleColor/g, opt.c1
        data = data.replace /lightColor/g, opt.c2
        data = data.replace /1s/g, "#{opt.speed}s"
        data = uilresize data, \sunny, opt
      custom: (s, e, a, c) ->
        a.$observe 'circleColor' (v) -> if v =>
          e.find \circle .css \fill, v
        a.$observe 'lightColor' (v) -> if v =>
          e.find \path .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \g .each ~>
         $(&1)attr \transform, "rotate(#{60 * (( delay % 1000 ) / 1000)} 50 50)"
