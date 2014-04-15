<- define <[]>
angular.module \uiloading
  ..factory \uilType-facebook, ($interval) ->
    start = null
    ret = do
      mode: \both
      vars: 
        [{ name: 'color', placeholder: '#f00', type: 'color', default: '#000', attr: 'color' }]
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) -> 
        data = data.replace /#000|black/g, "#{opt.c1}"
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-facebook-css"/, "'uil-facebook-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
        for i from 3 to 1 by -1 =>
          begin = "#{parse-int(((i - 1) * opt.speed / 10) * 100) / 100 }s"
          data = data.replace(new RegExp("begin#i", "g"), begin)
        data
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) -> if v =>
          e.find "g > rect" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \rect .each ->
          v = 1 + ((1000 - ((delay + (2 - &0) * 100) % 1000)) / 1000)**4
          $(&1)attr \transform, "scale(#v)"
