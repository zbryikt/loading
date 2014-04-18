<- define <[]>
angular.module \uiloading
  ..factory \uilType-infinity, ($interval) ->
    offset = [0 100 200 300 400]
    ret = do
      mode: \svg
      vars:
        * name: 'circle color', placeholder: '#000', type: 'color', default: '#ff0000', attr: 'circle-color'
        * name: 'line color', placeholder: '#000', type: 'color', default: '#c0bb9c', attr: 'line-color'
      patch-svg: (data, opt) -> @patch data, opt
      patch-css: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /circleColor/g, opt.c1
        data = data.replace /lineColor/g, opt.c2
        data = data.replace /duration/g, "#{opt.speed}s"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        # always do this reversely so begin1 won't override begin12
        for i from 5 to 1 by -1 =>
          begin = "#{parse-int(((i - 1) * opt.speed / 12) * 100) / 100 }s"
          data = data.replace(new RegExp("begin#i", "g"), begin)
        data
      custom: (s, e, a, c) ->
        a.$observe 'circleColor' (v) -> if v =>
          e.find \circle .css \fill, v
        a.$observe 'lineColor' (v) -> if v =>
          e.find \path .css \stroke, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect .css \fill, v

      start: (s, e, a, c) ->
        @path = document.getElementById("uil-inf-path")
        if @path => @length = @path.get-total-length!
      stop:  (s, e, a, c) ->
      step:  (s, e, a, c, delay) ->
        if !@path => @start s,e,a,c
        e.find \circle .each ~>
          ptr = @path.get-point-at-length @length * parse-float(( (delay + offset[&0]) % 1000 ) / 1000.0)
          $(&1).attr \cx, ptr.x
          $(&1).attr \cy, ptr.y
