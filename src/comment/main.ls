<- define <[]>
angular.module \uiloading
  ..factory \uilType-comment, ($interval,uilresize) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        * name: 'color1', placeholder: '#999', type: 'color', default: '#999', attr: 'color1'
        * name: 'color2', placeholder: '#fff', type: 'color', default: '#fff', attr: 'color2'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /#000|black/g, "#{opt.c1}"
        data = data.replace /#fff|white/g, "#{opt.c2}"
        data = uilresize data, \comment, opt
      custom: (s, e, a, c) ->
        a.$observe 'color1' (v) -> if v => e.find "path" .css \fill, v
        a.$observe 'color2' (v) -> if v => e.find "circle" .css \fill, v
        a.$observe 'background' (v) -> if v => e.find \rect.bk .css \fill, v
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        e.find \circle .each ~>
          v = ( delay % 1000 ) / 1000
          $(&1)attr \opacity, ( v - (&0) * 0.2  >?0 <? 0.2 ) / 0.2
