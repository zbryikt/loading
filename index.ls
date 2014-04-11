
require.config do
  base-url: \static/js/
  paths: do
    uiloading: \/uiload

<- require <[uiloading]>
angular.module \main, <[uiloading]>
  ..factory \svg2canvas, -> (svg, cb) ->
    canvas = document.createElement \canvas
    svg = svg.trim!
    canvg canvas, svg, renderCallback: -> cb canvas
  ..factory \capture, ($timeout, svg2canvas) -> (model, delta, cb) ->
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
                $(\#output-gif).html ""
                $(\#output-gif).append $(img)
                $(\#output-gif-link).attr \href, URL.createObjectURL blob
                $(\#output-gif-link).attr \download, model.type
                cb!
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

  ..controller \main, <[$scope $timeout $interval capture]> ++ ($scope, $timeout, $interval, capture) ->
    $scope.delay = 0
    $scope.delta = 30
    $scope.$watch 'build.speed' (v) ->
      if v > 0 => $scope.delta = 30 / v
    $scope.$watch 'demoLoader' -> 
      if $scope.demo-loader =>
        $timeout ->
          $scope.demo-loader.start!
          $interval (-> if !$scope.build.making =>
            $scope.demo-loader.step $scope.delay
            if $scope.build.running => $scope.delay = ( $scope.delay + $scope.delta ) % 1000
          ), 30
        , 1000
    $scope.build = do
      running: true
      making: false
      done: false
      speed: 1
      start: -> @running = true
      stop: -> @running = false
      makegif: -> 
        @ <<< {done: false, making: true}
        @stop!
        capture $scope.demoLoader, $scope.delta, ~>
          $(\#output-modal).modal \show
          @ <<< {done: true, making: false}


angular.bootstrap $("body"), <[main]>
