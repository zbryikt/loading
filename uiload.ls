angular.module \uiloading, <[]>
  ..factory \uilSvg, -> 'width="100%" height="100%" viewBox="0 0 100 100"'

<- define <[default]>
angular.module \uiloading
  ..directive \uiload, ($injector, $http, $templateCache, $timeout) -> do
    restrict: \E
    template: ""
    scope: p: \=ngModel
    link: (scope, e, attrs, ctrl) ->
      type = attrs[\type] or "default"
      try mod = $injector.get "uilType-#type"
      catch => return console.log("module not found.")
      scope.url = "static/html/#type.html"
      if not (\js of attrs) => e.add-class \anim
      $http.get "static/html/#type.html", cache: $templateCache .success (content) ->
        e.html content
        #if \js of attrs => $timeout (-> mod.start scope, e, attrs, ctrl ), 0
      scope.p = 
        node: e
        start: -> mod.start scope, e, attrs, ctrl
        stop: -> mod.stop scope, e, attrs, ctrl
        step: -> mod.step scope, e, attrs, ctrl, it

      #e.html(uilmarkup[type])
      #uiloadcustom scope,e, attrs, type

