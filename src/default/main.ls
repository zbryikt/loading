<- define <[]>
angular.module \uiloading
  ..factory \uilType-default, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \both
      count: 12
      width: 7
      height: 20
      radius: 5
      offset: 30
      color: \#00b2ff
      speed: 1
      vars: 
        * name: 'color', placeholder: '#000', type: 'color', default: '#00b2ff', attr: 'color'
        * name: 'count', placeholder: '12', type: 'px', default: '12', attr: 'count'
        * name: 'width', placeholder: '7', type: 'px', default: '7', attr: 'width'
        * name: 'height', placeholder: '20', type: 'px', default: '20', attr: 'height'
        * name: 'radius', placeholder: '5', type: 'px', default: '5', attr: 'radius'
        * name: 'offset', placeholder: '30', type: 'px', default: '30', attr: 'offset'
      patch-svg: (data, opt) -> 
        svg-head = '<svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" '+
        'viewBox="0 0 100 100" preserveAspectRatio="xMidYMid" class="uil-default">'+
        '<rect x="0" y="0" width="100" height="100" fill="none" class="bk"></rect>'
        svg = ""
        for i from 0 til @count =>
          svg += "<rect " +
          " x='#{50 - @width/2}' y='#{50 - @height/2}'" +
          " width='#{@width}' height='#{@height}'" +
          " rx='#{@radius}' ry='#{@radius}'" +
          " fill='#{@color}'" +
          " transform='rotate(#{360 * i / @count} 50 50) translate(0 -#{@offset})'>"+
          "  <animate attributeName='opacity' from='1' to='0' dur='#{opt.speed}s'"+
          " begin='#{i * opt.speed / @count}s' repeatCount='indefinite'/>"+
          "</rect>"
        svg = svg-head + svg + "</svg>"
        svg = uilresize svg, \default, opt

      patch-css: (data, opt) ->
        [html,css] = ["",""]
        keyframes = "{ 0% { opacity: 1} 100% {opacity: 0} }"
        speed = opt.speed
        animation-value = "uil-default-anim #{speed}s linear infinite"
        css = "@-webkit-keyframes uil-default-anim #{keyframes}"+
        "@keyframes uil-default-anim #{keyframes}"
        for i from 0 til @count 
          transform = "rotate(#{parseInt(360 * i / @count)}deg) translate(0,-#{@offset * 2}px)"
          style = "top:#{100 - @height}px;left:#{100 - @width}px;width:#{@width * 2}px;height:#{@height * 2}px;" +
            "background:#{@color};-webkit-transform:#{transform};transform:#{transform};" +
            "border-radius:#{@radius * 2}px;position:absolute;"
          one-css = ".uil-default-css > div:nth-of-type(#{i+1}){"+
          "-webkit-animation: #{animation-value};"+
          "animation: #{animation-value};"+
          "-webkit-animation-delay: #{i*speed / @count - speed / 2}s;"+
          "animation-delay: #{i*speed / @count - speed / 2}s;"+
          "}"
          css += one-css
          html += "<div style='#{style}'></div>"
        html = "<style type='text/css'>#{css}</style><div class=\"uil-default-css\">#{html}</div>"
        html = uilresize html, \default, opt

      render: (s, e, a, c, opt) ->
        @ <<< opt
        svg = d3.select(e.0)select \svg
        svg.selectAll(\rect.bar).data [(i * 360 / @count) for i from 0 til @count]
          ..exit!remove!
          ..enter!append \rect .attr \class, \bar
        svg.selectAll \rect.bar
          .attr do
            x: "#{50 - @width/2}"
            y: "#{50 - @height/2}"
            width: @width
            height: @height
            fill: @color
            rx: @radius
            ry: @radius
            transform: (d,i) ~> "rotate(#{360 * i / @count} 50 50) translate(0 -#{@offset})"
      custom: (s, e, a, c) ->
        a.$observe 'color' (v) ~> if v => @render s,e,a,c,color: v
        a.$observe 'count' (v) ~> if v => @render s,e,a,c,count: v
        a.$observe 'width' (v) ~> if v => @render s,e,a,c,width: v
        a.$observe 'height' (v) ~> if v => @render s,e,a,c,height: v
        a.$observe 'radius' (v) ~> if v => @render s,e,a,c,radius: v
        a.$observe 'offset' (v) ~> if v => @render s,e,a,c,offset: v
        a.$observe 'background' (v) -> if v => e.find \rect.bk .css \fill, v

      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
        v = ( delay % 1000 ) / 1000
        e.find \rect.bar .each ~>
          v = ( ( delay + ((@count - &0 - 1) * 1000 / @count) ) % 1000 ) / 1000
          $(&1)attr \opacity, v
