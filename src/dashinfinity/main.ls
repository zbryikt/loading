<- define <[]>
angular.module \uiloading
  ..factory \uilType-dashinfinity, ($interval) ->
    start = null
    ret = do
      mode: \svg
      vars: 
        * name: 'line color', placeholder: '#f00', type: 'color', default: '#000', attr: 'line-color'
        * name: 'dash length', placeholder: '5', type: 'px', default: '5', attr: 'dash-length'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) ->
        data = data.replace /#000/g, "#{opt.c1}"
        data = data.replace /stroke-dasharray="5"/g, "stroke-dasharray='#{opt.c2}'"
        data = data.replace /1s/g, "#{opt.speed}s"
        data = data.replace /svg width="100%" height="100%"/, "svg width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
        console.log data
        data
      custom: (s, e, a, c) ->
        a.$observe 'lineColor' (v) -> if v =>
          e.find \path .css \stroke, v
        a.$observe 'dashLength' (v) -> if v =>
          e.find \path .css \stroke-dasharray, v
        a.$observe 'background' (v) -> if v =>
          e.find \rect .css \fill, v
      start: (s, e, a, c) ->
        @path = e.find \path .0
        if @path => @length = @path.get-total-length!
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        if !@path => @start s,e,a,c
        if !@path => return
        e.find \path .css "stroke-dashoffset", @length * (delay % 1000) / 1000
