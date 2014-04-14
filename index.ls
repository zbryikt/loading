
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
  ..factory \capture, ($timeout, svg2canvas, outputmodal) -> (model, delta, cb) ->
    ret = {} <<< do
      delta: delta
      step: 0
      target: null
      gif: new GIF workers: 2, quality: 10, transparent: 0xFFFFFF
      addframe: (canvas) ->
        console.log @step
        @gif.add-frame canvas,  delay: 20
        if @step >= 1000 + @delta =>
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
            html = @target.node.html!replace /svg width="100%" height="100%"/,"svg width='#w' height='#h'"
            svg2canvas html, ~> @addframe it 
          ) ,100
      start: (model) -> 
        @ <<< {step: 0, target: model}
        $timeout (~> @runner!), 100
        @
    ret.start model

  ..controller \main, <[$scope $injector $timeout $interval $http $compile capture outputmodal]> ++ ($scope, $injector, $timeout, $interval, $http, $compile, capture, outputmodal) ->
    $scope.delay = 0
    $scope.delta = 30
    $scope.ani-timer = null
    $scope.$watch 'build.speed' (v) ->
      if v > 0 => $scope.delta = 30 / v
    $scope.$watch 'demoLoader' -> 
      if $scope.demo-loader =>
        for item,i in $scope.demo-loader.vars
          $scope.build["c#{i + 1}"] = item.default
        if !$scope.ani-timer => $scope.ani-timer = $timeout ->
          #$scope.demo-loader.start!
          $interval (-> if !$scope.build.making =>
            $scope.demo-loader.step $scope.delay
            if $scope.build.running => $scope.delay = ( $scope.delay + $scope.delta ) % 1000
          ), 30
        , 1000
    $scope.build = do
      choices: <[default infinity ellipsis]>
      size: 60
      running: true
      making: false
      done: false
      speed: 1
      start: -> @running = true
      stop: -> @running = false
      type: \default
      settype: (type) -> set-timeout (~>
        @type = type
        try mod = $injector.get "uilType-#type"
        catch => return console.log("module not found.")
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
      resize: (e) -> 
        total = 200 # $(e.target or e.srcElement)width!
        @size = parse-int( 100 * ( e.offsetX >? 50 <? 200 ) / ( total ? 200 ) )
      makesvg: ->
        type = $scope.demoLoader.type
        (raw-svg) <- $http.get "/static/html/#{type}.svg.html" .success
        raw-svg = '<?xml version="1.0" encoding="utf-8"?>' + raw-svg
        svg = $scope.demo-loader.patch-svg raw-svg, $scope.build
        outputmodal.create $(svg), new Blob([svg],type:'text/html'), type, \SVG
      makecss: ->
        type = $scope.demoLoader.type
        (raw-html) <- $http.get "/static/html/#{type}.css.html" .success
        (raw-css) <- $http.get "/static/css/#{type}.css" .success
        data = "<style type='text/css'> #{raw-css} </style> #{raw-html}"
        data = $scope.demo-loader.patch-css data, $scope.build
        outputmodal.create $(data), new Blob([data],type:'text/html'), type, \CSS
      makegif: -> 
        @ <<< {done: false, making: true}
        @stop!
        capture $scope.demoLoader, $scope.delta, (img, blob, type) ~>
          outputmodal.create img, blob, type, \GIF
          @ <<< {done: true, making: false}
    $(\.ttn)tooltip!
    $timeout (-> $scope.build.settype \default), 0


angular.bootstrap $("body"), <[main]>
