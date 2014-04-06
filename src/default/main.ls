<- define <[]>
angular.module \uiloading
  ..factory \uilType-default, ($interval) ->
    offset = [0 125 250 375 500 625 750 875]
    intp-percent = [0 250 500 510 750 1000]
    intp-value = [0.42 0.26 0.1 1.0 0.8 0.54]
    start = null
    intp-func = (now) ->
      len = intp-percent.filter(-> it < now)length
      ep = intp-percent[len]
      sp = intp-percent[len - 1]
      ev = intp-value[len]
      sv = intp-value[len - 1]
      ( ev - sv ) * ( now - sp ) / ( ep - sp ) + sv

    ret = do
      start: (s, e, a, c) ->
        s.timer = $interval ~>
          if start == null => start := new Date!getTime!
          now = new Date!getTime!
          @step s,e,a,c,now
        , 30
      stop: (s, e, a, c) ->
        if s.timer => $interval.cancel s.timer
      step: (s, e, a, c, delay) ->
        e.find ".uil-default > div > div" .each ->
          delta = ( delay + offset[7 - &0] ) % 1000
          $(&1)css \opacity, intp-func delta

