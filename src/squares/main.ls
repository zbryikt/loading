<- define <[]>
angular.module \uiloading
  ..factory \uilType-squares, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'dark color', placeholder: '#000', type: 'color', default: '#047ab3', attr: 'dark-color'
        * name: 'light color', placeholder: '#000', type: 'color', default: '#00cde8', attr: 'light-color'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /darkColor/g, opt.c1
        data = data.replace /lightColor/g, opt.c2
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /s18/g, "#{(0 * opt.speed / 8)}s"
        data = data.replace /s28/g, "#{(1 * opt.speed / 8)}s"
        data = data.replace /s38/g, "#{(2 * opt.speed / 8)}s"
        data = data.replace /s48/g, "#{(3 * opt.speed / 8)}s"
        data = data.replace /s58/g, "#{(4 * opt.speed / 8)}s"
        data = data.replace /s68/g, "#{(5 * opt.speed / 8)}s"
        data = data.replace /s78/g, "#{(6 * opt.speed / 8)}s"
        data = data.replace /s88/g, "#{(7 * opt.speed / 8)}s"
        data = uilresize data, \squares, opt
      darkColor: \#000
      lightColor: \#999
      custom: (s, e, a, c) ->
        a.$observe 'darkColor' (v) ~> if v =>
          @darkColor = v
          @color = d3.scale.linear!domain [0,1] .range [@lightColor,@darkColor]
        a.$observe 'lightColor' (v) ~> if v =>
          @lightColor = v
          @color = d3.scale.linear!domain [0,1] .range [@lightColor,@darkColor]
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      color: d3.scale.linear!domain [0,1] .range <[#999 #000]>
      step: (s, e, a, c, delay) ->
        e.find \rect.sq .each ~>
          v = ((((1000 - (&0* 125) + delay) % 1000) - 100)>?0 <?100 ) / 100
          $(&1)attr \fill, @color v
