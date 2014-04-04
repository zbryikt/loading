angular.module \uiloading, <[]>
  ..factory \uiloadtype, -> do
    spin:
      '<div class="uil-spin">' + 
      '<div><div></div></div>' + 
      '<div><div></div></div>' + 
      '<div><div></div></div>' + 
      '<div><div></div></div>' + 
      '<div><div></div></div>' + 
      '<div><div></div></div>' + 
      '<div><div></div></div>' + 
      '<div><div></div></div>' + 
      '</div>'
    circle:
      '<div class="uil-circle">' + 
      '<div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div>' +
      '</div>'
    reload: '<div class="uil-reload"></div>'
    pie: '<div class="uil-pie">' +
      '<div><div></div></div><div><div></div></div><div><div></div></div>' +
      '</div>'
    pacman: '<div class="uil-pacman">' +
      '<div><div></div></div><div><div></div></div><div><div></div></div>' +
      '</div>'

  ..directive \uiload, (uiloadtype) -> do
    restrict: \E
    template: ""
    link: (scope, e, attrs, ctrl) ->
      e.html(uiloadtype[attrs[\type]] or "")
