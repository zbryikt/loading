<- define <[]>
angular.module \uiloading
  ..factory \uilType-pacman, ($interval) ->
    start = null
    ret = do
      mode: \both
      angle: 30
      vars: 
        * name: 'color', placeholder: '#f00', type: 'color', default: '#000', attr: 'color'
        * name: 'angle', placeholder: '#f00', type: 'px', default: '30', attr: 'angle'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /#000|black/g, "#{opt.c1}"
        data = data.replace /30deg/g, "#{opt.c2}deg"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-pacman-css"/, "'uil-pacman-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) -> if v => e.find \path .css \fill, v
        a.$observe 'angle' (v) ~> if v and !isNaN v => @angle = parse-int v
        a.$observe 'background' (v) -> if v => e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \path .each ~>
          r = Math.abs(@angle * 2 * (500 - (delay % 1000)) / 1000)
          $(&1)attr \transform, "rotate(#{(if &0 => -1 else 1) * r} 50 50)"
