<- define <[]>
angular.module \uiloading
  ..factory \uilType-wave, ($interval,uilresize) ->
    start = null
    ret = do
      mode: \svg
      speed: 1
      speed-rate: [1 1]
      vars: 
        * name: 'outer color', placeholder: '#000', type: 'color', default: '#c123cf', attr: 'outer-color'
        * name: 'outer speed rate', placeholder: '1', type: 'px', default: '1', attr: 'outer-speed'
        * name: 'inner color', placeholder: '#fff', type: 'color', default: '#fdff8c', attr: 'inner-color'
        * name: 'inner speed rate', placeholder: '1', type: 'px', default: '1', attr: 'inner-speed'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /outerColor/g, opt.c1
        data = data.replace /innerColor/g, opt.c3
        data = data.replace /outerSpeed/g, opt.c2 * @speed
        data = data.replace /innerSpeed/g, opt.c4 * @speed
        data = uilresize data, \wave, opt
        data
      custom: (s, e, a, c) ->
        a.$observe 'outerColor' (v) -> if v => e.find "path:nth-of-type(1)" .css \fill, v
        a.$observe 'innerColor' (v) -> if v => e.find "path:nth-of-type(2)" .css \fill, v
        a.$observe 'outerSpeed' (v) ~> if v => @speed-rate.0 = parse-int( v >? 1 <? 10 )
        a.$observe 'innerSpeed' (v) ~> if v => @speed-rate.1 = parse-int( v >? 1 <? 10 )
        a.$observe 'background' (v) -> if v => e.find \rect .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \path .each ~>
          v = @speed-rate[&0] * ( &0*2 - 1) * -45 * ( delay % 1000 ) / 1000
          $(&1)attr \transform, "rotate(#v 50 50)"

