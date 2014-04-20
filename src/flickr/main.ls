<- define <[]>
angular.module \uiloading
  ..factory \uilType-flickr, ($interval,uilresize) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'color1', placeholder: '#06d', type: 'color', default: '#0462dc', attr: 'color1'
        * name: 'color2', placeholder: '#f08', type: 'color', default: '#fc0284', attr: 'color2'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /color1/g, opt.c1
        data = data.replace /color2/g, opt.c2
        data = data.replace /1s/g, "#{opt.speed}s"
        data = uilresize data, \flickr, opt
      custom: (s, e, a, c) ->
        a.$observe 'color1' (v) -> if v =>
          e.find "circle:nth-of-type(2n+1)" .css \fill, v
        a.$observe 'color2' (v) -> if v =>
          e.find "circle:nth-of-type(2)" .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \circle .each ~>
          o = ( delay % 1000 ) / 1000
          v = 2 * Math.abs( 500 - (delay % 1000) ) / 1000
          if (&0 % 2) == 0 => x = v * 50 + 25
          else => x = (1 - v) * 50 + 25
          $(&1)attr \cx, x
          if &0 == 2 => $(&1)attr \opacity, if o>=0.5 => 1 else 0
