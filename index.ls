require.config do
  base-url: \static/js/
  paths: do
    uiloading: \/uiload

<- require <[uiloading]>
angular.module \main, <[uiloading]>
  ..controller \main, <[$scope $interval $timeout]> ++ ($scope, $interval, $timeout) ->
    console.log \main
    $scope.xx = 1
    $scope.infinity = circle: \#000, line: \#f00, speed: \1s
    $scope.gif = new GIF workers: 2, quality: 10, transparent: 0xFFFF00
    $scope.$watch 'a' -> if $scope.a =>
      $scope.step = 0
      timer = $interval ->
        $scope.a.step $scope.step
        html2canvas $scope.a.node, do
          onrendered: ->
            $scope.step += 100
            $scope.gif.add-frame it, delay: 100, copy: true
            if $scope.step == 1000 =>
              $interval.cancel timer
              $scope.gif.on \finished, (blob) ->
                reader = new window.FileReader!
                reader.readAsDataURL blob
                reader.onloadend = ->
                  img = document.createElement("img")
                  console.log reader.result
                  img.src = reader.result
                  $(document.body).append $(img)
                #window.open URL.createObjectURL(blob)
              $scope.gif.render!
      , 2000

angular.bootstrap $("body"), <[main]>
