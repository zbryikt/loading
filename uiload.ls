angular.module \uiloading, <[]>
  ..factory \uilSvg, -> 'width="100%" height="100%" viewBox="0 0 100 100"'

<- define <[default infinity ellipsis dashinfinity reload wheel g0v pacman facebook spin ball cube circle pie radio poi gear gears comment wave]>
angular.module \uiloading
  ..factory \uilresize, -> (data, type, opt) ->
    data = data.replace /width="100%" height="100%"/, "width='#{opt.size * 2}px' height='#{opt.size * 2}px'"
    data = data.replace new RegExp("\"uil-#{type}-css\""),
      "'uil-#{type}-css' style='-webkit-transform:scale(#{opt.size * 2 / 200})'"
  ..directive \uiload, ($injector, $http, $templateCache, $timeout) -> do
    restrict: \E
    template: ""
    scope: p: \=ngModel
    link: (scope, e, attrs, ctrl) ->
      type = attrs[\type] or "default"
      js = \js of attrs
      try mod = $injector.get "uilType-#type"
      catch => return console.log("module not found.")
      scope.url = "static/html/#type.#{if mod.type!=\css => ( if js => \svg.static else \svg) else => \css}.html"
      console.log scope.url
      if not js => e.add-class \anim
      $http.get scope.url, cache: $templateCache .success (content) ->
        e.html content
        if not js => $timeout (-> mod.start scope, e, attrs, ctrl ), 0
      scope.p = do
        node: e
        speed: mod.speed or 1
        mode: mod.mode
        vars: mod.vars
        type: type
        start: ->
          mod.start scope, e, attrs, ctrl
        stop: -> mod.stop scope, e, attrs, ctrl
        step: -> mod.step scope, e, attrs, ctrl, it
        patch-svg: (svg, opt) -> mod.patch-svg svg, opt
        patch-css: (css, opt) -> mod.patch-css css, opt
      if mod.custom => 
        mod.custom scope, e, attrs, ctrl

