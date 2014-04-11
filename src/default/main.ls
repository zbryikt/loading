<- define <[]>
angular.module \uiloading
  ..factory \uilType-default, ($interval) ->
    offset = [0 83 166 250 333 416 500 583 666 750 833 916 1000]
    start = null
    ret = do
      mode: \both
      custom: (s, e, a, c) ->
        a.$observe 'barColor' (v) -> if v =>
          e.find \rect.bar .css \fill, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
        if s.timer => $interval.cancel s.timer
      step: (s, e, a, c, delay) ->
        e.find "rect.bar" .each ->
          delta = ( delay + offset[12 - &0] ) % 1000
          $(&1)css \opacity, delta / 1000
