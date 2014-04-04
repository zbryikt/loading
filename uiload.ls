angular.module \uiloading, <[]>
  ..factory \uiloadtype, -> do
    default:
      '<div class="uil-def">' + 
      '<div><div></div></div><div><div></div></div>' + 
      '<div><div></div></div><div><div></div></div>' + 
      '<div><div></div></div><div><div></div></div>' + 
      '<div><div></div></div><div><div></div></div>' + 
      '</div>'
    spin:
      '<div class="uil-spin">' + 
      '<div><div></div></div><div><div></div></div>' + 
      '<div><div></div></div><div><div></div></div>' + 
      '<div><div></div></div><div><div></div></div>' + 
      '<div><div></div></div><div><div></div></div>' + 
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
    facebook: '<div class="uil-fb"><div></div><div></div><div></div></div>'
    rosary: '<div class="uil-rosary">' + 
      '<div><div></div></div>' +
      '<div><div></div></div>' +
      '<div><div></div></div>' +
      '<div><div></div></div>' +
      '<div><div></div></div>' +
      '</div>'
    cube: '<div class="uil-cube"><div></div><div></div><div></div><div></div></div>'

  ..directive \uiload, (uiloadtype) -> do
    restrict: \E
    template: ""
    link: (scope, e, attrs, ctrl) ->
      e.html(uiloadtype[attrs[\type]] or "")
