// Generated by LiveScript 1.2.0
var x$;
x$ = angular.module('uiloading', []);
x$.factory('uilSvg', function(){
  return 'width="100%" height="100%" viewBox="0 0 100 100"';
});
define(['default', 'infinity'], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.directive('uiload', function($injector, $http, $templateCache, $timeout){
    return {
      restrict: 'E',
      template: "",
      scope: {
        p: '=ngModel'
      },
      link: function(scope, e, attrs, ctrl){
        var type, js, mod;
        type = attrs['type'] || "default";
        js = 'js' in attrs;
        try {
          mod = $injector.get("uilType-" + type);
        } catch (e$) {
          e = e$;
          return console.log("module not found.");
        }
        scope.url = "static/html/" + type + "." + (mod.type !== 'css' ? js ? 'svg.static' : 'svg' : 'css') + ".html";
        console.log(scope.url);
        if (!js) {
          e.addClass('anim');
        }
        $http.get(scope.url, {
          cache: $templateCache
        }).success(function(content){
          e.html(content);
          if (!js) {
            return $timeout(function(){
              return mod.start(scope, e, attrs, ctrl);
            }, 0);
          }
        });
        scope.p = {
          node: e,
          mode: mod.mode,
          type: type,
          start: function(){
            console.log('ok');
            return mod.start(scope, e, attrs, ctrl);
          },
          stop: function(){
            return mod.stop(scope, e, attrs, ctrl);
          },
          step: function(it){
            return mod.step(scope, e, attrs, ctrl, it);
          }
        };
        if (mod.custom) {
          return mod.custom(scope, e, attrs, ctrl);
        }
      }
    };
  });
  return x$;
});