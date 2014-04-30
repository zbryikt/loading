<- define <[]>
angular.module \uiloading
  ..factory \uilType-clock, ($interval, uilresize) ->
    start = null
    ret = do
      speed: 5
      mode: \both
      vars: 
        * name: 'circle color', placeholder: '#000', type: 'color', default: '#2b74ba', attr: 'circle-color'
        * name: 'clock color', placeholder: '#000', type: 'color', default: '#d6f1ff', attr: 'clock-color'
        * name: 'line color1', placeholder: '#000', type: 'color', default: '#000', attr: 'line-color1'
        * name: 'line color2', placeholder: '#f00', type: 'color', default: '#f00', attr: 'line-color2'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /circleColor/g, opt.c1
        data = data.replace /clockColor/g, opt.c2
        data = data.replace /lineColor1/g, opt.c3
        data = data.replace /lineColor2/g, opt.c4
        data = data.replace /duration1/g, "#{opt.speed/5}s"
        data = data.replace /duration2/g, "#{opt.speed}s"
        data = uilresize data, \clock, opt
      custom: (s, e, a, c) ->
        a.$observe 'circleColor' (v) -> if v =>
          e.find "circle" .css \stroke, v
        a.$observe 'clockColor' (v) -> if v =>
          e.find "circle" .css \fill, v
        a.$observe 'lineColor1' (v) -> if v =>
          e.find "line:nth-of-type(1)" .css \stroke, v
        a.$observe 'lineColor2' (v) -> if v =>
          e.find "line:nth-of-type(2)" .css \stroke, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \line .each ~>
          v = 360 * 5 *( delay % 1000 ) / 1000
          if &0==0 => v /= 5
          $(&1)attr \transform, "rotate(#{v} 50 50)"
