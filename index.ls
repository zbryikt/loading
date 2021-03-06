
require.config do
  base-url: \static/js/
  paths: do
    uiloading: \/uiload

<- require <[uiloading]>
angular.module \main, <[uiloading colorpicker.module]>
  ..directive \delayBk, -> do
    restrict: \A
    link: (scope, e, attrs, ctrl) ->
      url = attrs["delayBk"]
      $ \<img/> .attr \src url .load ->
        $(@)remove!
        e.css "background-image": "url(#url)"
        e.toggle-class \visible
  ..factory \svg2canvas, -> (svg, cb) ->
    canvas = document.createElement \canvas
    svg = svg.trim!
    canvg canvas, svg, renderCallback: -> cb canvas
  ..factory \outputmodal, -> do
    node: null
    url: null
    blob: null
    type: null
    mode: null
    create: (node, blob, type, mode)->
      @ <<< {node, blob, type, mode, url: URL.createObjectURL blob}
      $(\#output-box)html ""
      $(\#output-box)append $(@node)
      $(\#output-box-link)attr \href, @url
      $(\#output-box-link).attr \download, "#{@type}.#{mode.to-lower-case!}"
      $(\#output-modal).modal \show
  ..controller \output, <[$scope outputmodal]> ++ ($scope, outputmodal) ->
    $scope.outputmodal = outputmodal
    $scope.$watch 'outputmodal.mode' -> $scope.mode = outputmodal.mode
  ..factory \capture, ($timeout, svg2canvas, outputmodal) -> (model, delta, transparent, tick, cb) ->
    transparent = if transparent => transparent.replace "#", "0x" else "0xFFFFFF"
    ret = {} <<< do
      delta: delta
      step: 0
      target: null
      gif: new GIF workers: 2, quality: 10, transparent: transparent or 0xFFFFFF
      addframe: (canvas) ->
        console.log @step
        tick parse-int( @step / 10 ) <?100
        @gif.add-frame canvas, delay: 40
        if @step >= 1000 =>
          @gif.on \finished, (blob) ->
            reader = new window.FileReader!
            reader.readAsDataURL blob
            reader.onloadend = ->
              img = document.createElement("img")
              img.src = reader.result
              cb $(img), blob, model.type
          @gif.render!
        else 
          $timeout (~> @runner!), 10
      runner: ->
        @step += @delta
        @target.step @step
        if @target.mode == \css
          $timeout (~> html2canvas @target.node, onrendered: ~> @addframe it ), 100
        else
          $timeout (~> 
            #svg2canvas seems not able to parse 100%. workaround this..
            n = @target.node
            [w,h] = [n.width!, n.height!]
            html = @target.node.html!replace /width="100%" height="100%"/,"width='#w' height='#h'"
            svg2canvas html, ~> @addframe it 
          ) ,100
      start: (model) -> 
        @ <<< {step: 0, target: model}
        $timeout (~> @runner!), 100
        @
    ret.start model

  ..controller \main, <[$scope $injector $timeout $interval $http $compile capture outputmodal]> ++ ($scope, $injector, $timeout, $interval, $http, $compile, capture, outputmodal) ->
    $scope.delay = 0
    $scope.delta = 50
    $scope.$watch 'build', (v) ->
      now = new Date!getTime!
      vars-state = $scope.build.snapshot!
      if $scope.build.vars-state!=vars-state and now - $scope.build.update-time > 1000 =>
        ga \send, \event, \edit, \config, $scope.build.type
        $scope.build.vars-state = vars-state
        $scope.build.update-time = now
    , true
    $scope.$watch 'build.speed' (v) ->
      if v > 0 => $scope.delta = 50 / v
      if $scope.delta < 10 =>
        $scope.delta = 10
        $scope.build.speed = 5
    $scope.$watch 'demoLoader' -> 
      if $scope.demo-loader => 
        <- $timeout _, 500
        for item,i in $scope.demo-loader.vars
          $scope.build["c#{i + 1}"] = item.default
        if $scope.demo-loader.speed => $scope.build.speed = $scope.demo-loader.speed
        $scope.build.start!
        $scope.build.show = true
    $scope.build = do
      choices: <[default infinity ellipsis dashinfinity reload wheel g0v pacman facebook spin ball cube circle pie radio poi gear gears comment wave battery sunny triangle flickr ring spiral squares hourglass heart gps clock magnify]>
      anitimer: null
      size: 60
      running: true
      making: false
      done: false
      show: false
      speed: 1
      vars: []
      runner: -> if !$scope.build.making =>
        $scope.demo-loader.step $scope.delay
        if $scope.build.running => $scope.delay = ( $scope.delay + $scope.delta ) % 1000
      start: -> 
        if !@anitimer => @anitimer = $interval (~> @runner!), 50
        @running = true
      stop: -> 
        if @anitimer => 
          $interval.cancel @anitimer
          @anitimer = null
        @running = false
      type: \default
      snapshot: ->
        return [@[it] for it in @vars]join("/")
      settype: (type) -> set-timeout (~>
        ga \send, \event, \edit, \settype, type
        @stop!
        @show = false
        @type = type
        try mod = $injector.get "uilType-#type"
        catch => return console.log("module not found.")
        @vars = <[size speed cbk]> ++ ["c#i" for i from 1 to mod.vars.length]
        @vars-state = @snapshot!
        @update-time = new Date!getTime!
        custom-vars = ["#{v.attr}='{{build.c#{i + 1}}}'" for v,i in mod.vars]
        default-vars = ["type='#type'", "background='{{build.cbk}}'", "js", "ng-model='demoLoader'"]
        custom-style = [
          'style="'
          "width:{{build.size * 2}}px",
          "height:{{build.size * 2}}px",
          "margin:{{100 - build.size}}px"
          '"'
        ]join ";"
        html = $("<uiload #{(custom-vars ++ default-vars ++ [custom-style])join ' '}>")
        $(\#demo-panel)html ""
        $(\#demo-panel)append $compile(html)($scope)
        ), 0
      _resized: {}
      resize: (e) -> 
        if !@_resized[@type] =>
          ga \send, \event, \edit, \resize, @type
          @_resized[@type] = true
        total = 200 # $(e.target or e.srcElement)width!
        offset = e.offsetX or (e.pageX - $(e.target)offset!left)
        @size = parse-int( 100 * ( offset >? 32 <? 200 ) / ( total ? 200 ) )
      makesvg: ->
        ga \send, \event, \build, \svg, @type
        type = $scope.demoLoader.type
        (raw-svg) <- $http.get "/static/html/#{type}.svg.html" .success
        raw-svg = '<?xml version="1.0" encoding="utf-8"?>' + raw-svg
        svg = $scope.demo-loader.patch-svg raw-svg, $scope.build
        outputmodal.create $(svg), new Blob([svg],type:'text/html'), type, \SVG
      makecss: ->
        ga \send, \event, \build, \css, @type
        type = $scope.demoLoader.type
        (raw-html) <- $http.get "/static/html/#{type}.css.html" .success
        (raw-css) <- $http.get "/static/css/#{type}.css" .success
        data = "<style type='text/css'> #{raw-css} </style> #{raw-html}"
        data = $scope.demo-loader.patch-css data, $scope.build
        outputmodal.create $(data), new Blob([data],type:'text/html'), type, \CSS
      makegif: -> 
        ga \send, \event, \build, \gif, @type
        @ <<< {done: false, making: true}
        @stop!
        capture $scope.demoLoader, $scope.delta, @cbk, 
        ((percent) ~>
          $scope.$apply -> $scope.build.percent = percent), 
        ((img, blob, type) ~>
          outputmodal.create img, blob, type, \GIF
          $scope.$apply ~> @ <<< {done: true, making: false}
        )
    $(\.ttn)tooltip!
    $timeout (-> $scope.build.settype \default), 0
    $(window)scroll -> 
      if $(document.body)scroll-top! < 150 => $(\#nav-top)removeClass \dim
      else if $(document.body)scroll-top! > 150 => $(\#nav-top)addClass \dim
    attribution-data = [
      '"<a href="http://thenounproject.com/term/dots/21252/">Dots</a>", Istiko Rahadi, BY-CC 3.0'
      '"<a href="http://www.kingthingsfonts.co.uk/fonts/fonts.htm">Kingthings Sans</a>", Kingthings'
    ]

    $(\#attribution)popover do
      placement: \top
      html: \true
      title: "Attributions to Resources"
      content: attribution-data.join \<br>

    $(\#eula)popover do
      placement: \top
      html: \true
      title: "Term of Use"
      content: "All materials used in generating animated icons in this website, except the g0v icon, are created by loading.io. You can use them freely for any purpose."

    $(\#about)popover do
      placement: \top
      html: \true
      title: "About Us"
      content: "Loading.io is built upon several open source projects, including angularjs, canvg, svg2canvs, and gif.js."

    $(\#nav-more)tooltip do
      placement: \bottom
      title: "Coming Soon"

    $timeout (-> $(\#dimmer)fadeOut!), 1000

angular.bootstrap $("body"), <[main]>
