<- define <[]>
angular.module \uiloading
  ..factory \uilType-ellipsis, ($interval, uilresize) ->
    offset = [0 250 500 750]
    ani = do
      r: [0 1 1 1 1 1 1 0]
      x: [15 15 15 50 50 85 85 85]
    start = null
    ret = do
      mode: \both
      vars: 
        [{name: 'circle color', placeholder: '#f00', type: 'color', default: '#000'}]
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        #data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = uilresize data, \ellipsis, opt
        data = data.replace /circleColor/g, opt.c1
        data = data.replace /duration/g, "#{opt.speed}s"
        data = data.replace /s?1-8s/g, "#{1 * opt.speed / 8}s"
        data = data.replace /s?2-8s/g, "#{2 * opt.speed / 8}s"
        data = data.replace /s?3-8s/g, "#{3 * opt.speed / 8}s"
        data = data.replace /s?4-8s/g, "#{4 * opt.speed / 8}s"
        data = data.replace /s?5-8s/g, "#{5 * opt.speed / 8}s"
        data = data.replace /s?6-8s/g, "#{6 * opt.speed / 8}s"
        data
      custom: (s, e, a, c) ->
        a.$observe 'circleColor' (v) -> if v =>
          e.find \circle .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \circle .each ->
          p = parse-int( (delay % 1000) / 125 )
          p = (p + &0 * 2) % 8
          q = (p + 1) % 8
          d = delay % 125
          r = (( d / 125 ) * ( ani.r[q] - ani.r[p] )) + ani.r[p]
          x = (( d / 125 ) * ( ani.x[q] - ani.x[p] )) + ani.x[p]
          $(&1).attr \r, r * 15
          $(&1).attr \cx, x


