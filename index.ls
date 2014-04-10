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
  ..controller \main, <[$scope $interval $timeout svg2canvas]> ++ ($scope, $interval, $timeout, svg2canvas) ->
    $scope.infinity = circle: \#000, line: \#f00, speed: \1s
    $scope.capture = (model) ->
      ret = {} <<< do
        delta: 25
        step: 0
        target: null
        gif: new GIF workers: 2, quality: 10, transparent: 0xFFFFFF
        addframe: (canvas) ->
          console.log @step
          @gif.add-frame canvas,  delay: 20
          if @step == 1000 + @delta =>
            @gif.on \finished, (blob) ->
              reader = new window.FileReader!
              reader.readAsDataURL blob
              reader.onloadend = ->
                img = document.createElement("img")
                img.style.border='1px solid #000'
                img.src = reader.result
                $(document.body).append $(img)
            @gif.render!
          else 
            $timeout (~> @runner!), 10
        runner: ->
          @step += @delta
          @target.step @step
          if @target.mode == \css
            $timeout (~> html2canvas @target.node, onrendered: ~> @addframe it ), 100
          else
            $timeout (~> svg2canvas @target.node.html!, ~> @addframe it ) ,100
        start: (model) -> 
          @ <<< {step: 0, target: model}
          $timeout (~> @runner!), 100
          @
      ret.start model

    $scope.$watch 'a' -> if $scope.a => $scope.capture $scope.a
    $scope.$watch 'c' -> if $scope.c => $scope.capture $scope.c


angular.bootstrap $("body"), <[main]>
