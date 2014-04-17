<- define <[]>
angular.module \uiloading
  ..factory \uilType-circle, ($interval) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'color1', placeholder: '#000', type: 'color', default: '#f00', attr: 'color1'
        * name: 'color2', placeholder: '#fff', type: 'color', default: '#fff6e6', attr: 'color2'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) -> 
        data = data.replace /duration_2/g, "#{opt.speed * 2}s"
        data = data.replace /duration/g, "#{opt.speed}s"
        data = data.replace /#000|black/g, opt.c1
        data = data.replace /#fff|white/g, opt.c2
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-circle-css"/, "'uil-circle-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
        for i from 8 to 1 by -1 =>
          begin = "#{parse-int(((i - 1) * 2 * opt.speed / 8) * 100) / 100 }s"
          data = data.replace(new RegExp("begin#i", "g"), begin)
        data
      custom: (s, e, a, c) ->
        a.$observe 'color1' (v) -> if v =>
          e.find "circle:nth-of-type(2n)" .css \fill, v
        a.$observe 'color2' (v) -> if v =>
          e.find "circle:nth-of-type(2n+1)" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \circle .each ~>
          v = (7 - &0) * 15 - 30 * ((delay % 1000) / 1000)
          if v < 0 => v = 0
          $(&1)attr \r, v
