<- define <[]>
angular.module \uiloading
  ..factory \uilType-gps, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'outer color', placeholder: '#000', type: 'color', default: '#05c400', attr: 'outer-color'
        * name: 'inner color', placeholder: '#000', type: 'color', default: '#64f241', attr: 'inner-color'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /outerColor/g, opt.c1
        data = data.replace /innerColor/g, opt.c2
        data = data.replace /duration/g, "#{opt.speed}s"
        data = uilresize data, \gps, opt
      custom: (s, e, a, c) ->
        a.$observe 'outerColor' (v) -> if v =>
          e.find "path" .css \fill, v
        a.$observe 'innerColor' (v) -> if v =>
          e.find "circle" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \path .each ~>
          v = 180 * ( delay % 1000 ) / 1000 <? 90
          $(&1)attr \transform, "rotate(#{v} 50 50)"
        e.find \circle .each ~>
          v = ( delay % 1000 ) / 1000
          v = if v < 0.5 => ((0.5 - v) * 10) <?1
          else ((v - 0.9) * 10) >?0
          $(&1)attr \opacity, v
