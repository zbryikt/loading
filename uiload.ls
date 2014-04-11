angular.module \uiloading, <[]>
  ..factory \uilSvg, -> 'width="100%" height="100%" viewBox="0 0 100 100"'

<- define <[default infinity]>
angular.module \uiloading
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
      scope.p = 
        node: e
        mode: mod.mode
        type: type
        start: ->
          console.log \ok
          mod.start scope, e, attrs, ctrl
        stop: -> mod.stop scope, e, attrs, ctrl
        step: -> mod.step scope, e, attrs, ctrl, it
      if mod.custom => mod.custom scope, e, attrs, ctrl
      #uiloadcustom scope,e, attrs, type

