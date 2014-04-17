<- define <[]>
angular.module \uiloading
  ..factory \uilType-radio, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        * name: 'circle color', placeholder: '#000', type: 'color', default: '#eb8614', attr: 'circle-color'
        * name: 'wave color', placeholder: '#000', type: 'color', default: '#fb9610', attr: 'wave-color'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /circleColor/g, opt.c1
        data = data.replace /waveColor/g, opt.c2
        data = data.replace /duration/g, "#{opt.speed}s"
        data = data.replace /begin1/g, 0 * opt.speed / 10
        data = data.replace /begin2/g, 1 * opt.speed / 10
        data = data.replace /begin3/g, 2 * opt.speed / 10
        data = uilresize data, \radio, opt
      custom: (s, e, a, c) ->
        a.$observe 'circleColor' (v) -> if v => e.find \circle .css \fill, v
        a.$observe 'waveColor' (v) -> if v => e.find \path .css \fill, v
        a.$observe 'background' (v) -> if v => e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find "g > *" .each ->
          v = ( ( delay + (2 - &0) * 100 ) % 1000 ) / 500 <? 1
          $(&1)attr \opacity, v
