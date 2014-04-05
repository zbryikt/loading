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
    stripe: '<div class="uil-stripe"></div>'
    wheel: '<svg class="uil-wheel"><circle cx="50px" cy="50px" r="35px"></svg>'
    infinity: '<svg class="uil-inf">' +
      '<path id="uil-inf-path" d="' +
      'M24.3,30C11.4,30,5,43.3,5,50s6.4,20,19.3,20c19.3,0,32.1-40,51.4-40' +
      'C88.6,30,95,43.3,95,50s-6.4,20-19.3,20C56.4,70,43.6,30,24.3,30z"/>' + 
      '<circle x="-50" y="50" r="5">' +
      '<animateMotion begin="0s" dur="1s" repeatCount="indefinite">' +
      '<mpath xlink:href="#uil-inf-path"/>' +
      '</animationMotion></circle>' +
      '<circle x="-50" y="50" r="5">' +
      '<animateMotion begin="-0.1s" dur="1s" repeatCount="indefinite">' +
      '<mpath xlink:href="#uil-inf-path"/>' +
      '</animationMotion></circle>' +
      '<circle x="-50" y="50" r="5">' +
      '<animateMotion begin="-0.2s" dur="1s" repeatCount="indefinite">' +
      '<mpath xlink:href="#uil-inf-path"/>' +
      '</animationMotion></circle>' +
      '<circle x="-50" y="50" r="5">' +
      '<animateMotion begin="-0.3s" dur="1s" repeatCount="indefinite">' +
      '<mpath xlink:href="#uil-inf-path"/>' +
      '</animationMotion></circle>' +
      '<circle x="-50" y="50" r="5">' +
      '<animateMotion begin="-0.4s" dur="1s" repeatCount="indefinite">' +
      '<mpath xlink:href="#uil-inf-path"/>' +
      '</animationMotion></circle>' +
      '</svg>'
    dashinfinity: '<svg class="uil-dinf">' +
      '<path d="' +
       'M24.3,30C11.4,30,5,43.3,5,50s6.4,20,19.3,20c19.3,0,32.1-40,51.4-40' +
       'C88.6,30,95,43.3,95,50s-6.4,20-19.3,20C56.4,70,43.6,30,24.3,30z' +
      '"></svg>'

  ..directive \uiload, (uiloadtype) -> do
    restrict: \E
    template: ""
    link: (scope, e, attrs, ctrl) ->
      e.html(uiloadtype[attrs[\type]] or "")
