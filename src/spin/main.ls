<- define <[]>
angular.module \uiloading
  ..factory \uilType-spin, ($interval) ->
    start = null
    ret = do
      mode: \both
      speed: 1
      vars: 
        * name: 'color', placeholder: '#f00', type: 'color', default: '#000', attr: 'color'
        * name: 'radius', placeholder: '8', type: 'px', default: '8', attr: 'radius'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /#000|black/g, "#{opt.c1}"
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-spin-css"/, "'uil-spin-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
        # always do this reversely so begin1 won't override begin12
        for i from 8 to 1 by -1 =>
          begin = "#{parse-int(((i - 1) * opt.speed / 8) * 100) / 100 }s"
          data = data.replace(new RegExp("begin#i", "g"), begin)
        data
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) -> if v =>
          e.find "circle" .css \fill, v
        a.$observe 'radius' (v) -> if v =>
          e.find "circle" .attr \r, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \circle .each ~>
          v = ((( delay + @speed * ( 7 - &0 ) * 1000 / 8 ) % 1000 ) / 1000)
          $(&1)attr \opacity, 1 - v * 0.9
          $(&1)attr \transform, "scale(#{1.4 - v * 0.4})"
