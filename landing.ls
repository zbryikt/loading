
require.config do
  base-url: \static/js/
  paths: do
    uiloading: \/uiload

<- require <[uiloading]>
angular.module \main, <[uiloading]>
  ..controller \main, <[$scope $timeout $interval]> ++ ($scope, $timeout, $interval) ->
    $scope.delay = 0
    $scope.$watch 'demoLoader' -> 
      if $scope.demo-loader =>
        $timeout ->
          $scope.demo-loader.start!
          $interval ->
            $scope.demo-loader.step $scope.delay
            $scope.delay = ( $scope.delay + 30 ) % 1000
          , 30
        , 1000

angular.bootstrap $("body"), <[main]>
