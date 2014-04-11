<- define <[]>
angular.module \uiloading
  ..factory \uilType-infinity, ($interval) ->
    offset = [0 100 200 300 400]
    ret = do
      path: null
      mode: \svg
      custom: (s, e, a, c) ->
        a.$observe 'circleColor' (v) -> if v =>
          e.find \circle .css \fill, v
        a.$observe 'lineColor' (v) -> if v =>
          e.find \path .css \stroke, v
        a.$observe 'speed' (v) -> if v =>
          #v = parse-float v - /s/
          #if !v or isNaN v => return
          #e.find "circle *" .attr \dur, "#{v}s"
        a.$observe 'background' (v) -> if v =>
          e.find \rect .css \fill, v

      start: (s, e, a, c) ->
        @path = document.getElementById("uil-inf-path")
        @length = @path.get-total-length!
      stop:  (s, e, a, c) ->
      step:  (s, e, a, c, delay) ->
        e.find \circle .each ~>
          ptr = @path.get-point-at-length @length * parse-float(( (delay + offset[&0]) % 1000 ) / 1000.0)
          $(&1).attr \cx, ptr.x
          $(&1).attr \cy, ptr.y
