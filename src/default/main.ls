<- define <[]>
angular.module \uiloading
  ..factory \uilType-default, ($interval) ->
    offset = [0 83 166 250 333 416 500 583 666 750 833 916 1000]
    start = null
    ret = do
      mode: \both
      vars: 
        [ { name: 'bar color', placeholder: '#f00', type: 'color', default: '#000' } ]
        #* name: 'radius', placeholder: '5', type: 'px', default: '5'
        #* name: 'line color', placeholder: '#f00', type: 'color', default: '#f00'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /barColor/g, opt.c1
        data = data.replace /bkColor/g, opt.cbk
        data = data.replace /duration/g, "#{opt.speed}s"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        data = data.replace /"uil-default-css"/, "'uil-default-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
        # always do this reversely so begin1 won't override begin12
        for i from 12 to 1 by -1 =>
          begin = "#{parse-int(((i - 1) * opt.speed / 12) * 100) / 100 }s"
          data = data.replace(new RegExp("begin#i", "g"), begin)
        data
      custom: (s, e, a, c) ->
        a.$observe 'barColor' (v) -> if v => e.find \rect.bar .css \fill, v
        a.$observe 'background' (v) -> if v => e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
        if s.timer => $interval.cancel s.timer
      step: (s, e, a, c, delay) ->
        e.find "rect.bar" .each ->
          delta = ( delay + offset[12 - &0] ) % 1000
          $(&1)css \opacity, delta / 1000
