<- define <[]>
angular.module \uiloading
  ..factory \uilType-ball, ($interval) ->
    start = null
    ret = do
      mode: \both
      radius: 15
      vars: 
        * name: 'color', placeholder: '#f00', type: 'color', default: '#000', attr: 'color'
        * name: 'radius', placeholder: '15', type: 'px', default: '15', attr: 'radius'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /#000|black/g, "#{opt.c1}"
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /15/g, "#{opt.c2}"
        data = data.replace /ballRadius2/g, "#{4 * opt.c2}px"
        data = data.replace /ballRadius/g, "#{2 * opt.c2}px"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-ball-css"/, "'uil-ball-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) -> if v => e.find \circle .css \fill, v
        a.$observe 'radius' (v) ~> if v => 
          @radius = v
          e.find \circle .attr \r, v
        a.$observe 'background' (v) -> if v => e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \circle .each ->
          v = ( (500 - ( delay % 1000 )) / 500 ) ** 2
          $(&1)attr \cy, "#{20 + v * 60}"
