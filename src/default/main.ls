<- define <[]>
angular.module \uiloading
  ..factory \uilType-default, ($interval) ->
    offset = [0 83 166 250 333 416 500 583 666 750 833 916 1000]
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'bar color', placeholder: '#f00', type: 'color'
        * name: 'radius', placeholder: '5', type: 'px'
        * name: 'line color', placeholder: '#f00', type: 'color'
      patch: (svg, opt) ->
        console.log "patching default"
        svg = svg.replace /{{barColor}}/g, opt.c1
        svg = svg.replace /{{bkColor}}/g, opt.cbk
        svg = svg.replace /{{dur}}/g, "#{opt.speed}s"
        svg = svg.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        for i from 1 to 12 =>
          begin = "#{i * opt.speed / 12 }s"
          svg = svg.replace(new RegExp("{{begin#i}}", "g"), begin)
        svg
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
