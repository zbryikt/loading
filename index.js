// Generated by LiveScript 1.2.0
require.config({
  baseUrl: 'static/js/',
  paths: {
    uiloading: '/uiload'
  }
});
require(['uiloading'], function(){
  var x$;
  x$ = angular.module('main', ['uiloading', 'colorpicker.module']);
  x$.factory('svg2canvas', function(){
    return function(svg, cb){
      var canvas;
      canvas = document.createElement('canvas');
      svg = svg.trim();
      return canvg(canvas, svg, {
        renderCallback: function(){
          return cb(canvas);
        }
      });
    };
  });
  x$.factory('outputmodal', function(){
    return {
      node: null,
      url: null,
      blob: null,
      type: null,
      mode: null,
      create: function(node, blob, type, mode){
        this.node = node;
        this.blob = blob;
        this.type = type;
        this.mode = mode;
        this.url = URL.createObjectURL(blob);
        $('#output-box').html("");
        $('#output-box').append($(this.node));
        $('#output-box-link').attr('href', this.url);
        $('#output-box-link').attr('download', this.type + "." + mode.toLowerCase());
        return $('#output-modal').modal('show');
      }
    };
  });
  x$.controller('output', ['$scope', 'outputmodal'].concat(function($scope, outputmodal){
    $scope.outputmodal = outputmodal;
    return $scope.$watch('outputmodal.mode', function(){
      return $scope.mode = outputmodal.mode;
    });
  }));
  x$.factory('capture', function($timeout, svg2canvas, outputmodal){
    return function(model, delta, cb){
      var ret;
      ret = import$({}, {
        delta: delta,
        step: 0,
        target: null,
        gif: new GIF({
          workers: 2,
          quality: 10,
          transparent: 0xFFFFFF
        }),
        addframe: function(canvas){
          var this$ = this;
          console.log(this.step);
          this.gif.addFrame(canvas, {
            delay: 20
          });
          if (this.step >= 1000 + this.delta) {
            this.gif.on('finished', function(blob){
              var reader;
              reader = new window.FileReader();
              reader.readAsDataURL(blob);
              return reader.onloadend = function(){
                var img;
                img = document.createElement("img");
                img.src = reader.result;
                return cb($(img), blob, model.type);
              };
            });
            return this.gif.render();
          } else {
            return $timeout(function(){
              return this$.runner();
            }, 10);
          }
        },
        runner: function(){
          var this$ = this;
          this.step += this.delta;
          this.target.step(this.step);
          if (this.target.mode === 'css') {
            return $timeout(function(){
              return html2canvas(this$.target.node, {
                onrendered: function(it){
                  return this$.addframe(it);
                }
              });
            }, 100);
          } else {
            return $timeout(function(){
              var n, ref$, w, h, html;
              n = this$.target.node;
              ref$ = [n.width(), n.height()], w = ref$[0], h = ref$[1];
              html = this$.target.node.html().replace(/svg width="100%" height="100%"/, "svg width='" + w + "' height='" + h + "'");
              return svg2canvas(html, function(it){
                return this$.addframe(it);
              });
            }, 100);
          }
        },
        start: function(model){
          var this$ = this;
          this.step = 0;
          this.target = model;
          $timeout(function(){
            return this$.runner();
          }, 100);
          return this;
        }
      });
      return ret.start(model);
    };
  });
  x$.controller('main', ['$scope', '$injector', '$timeout', '$interval', '$http', '$compile', 'capture', 'outputmodal'].concat(function($scope, $injector, $timeout, $interval, $http, $compile, capture, outputmodal){
    $scope.delay = 0;
    $scope.delta = 30;
    $scope.aniTimer = null;
    $scope.$watch('build.speed', function(v){
      if (v > 0) {
        return $scope.delta = 30 / v;
      }
    });
    $scope.$watch('demoLoader', function(){
      var i$, ref$, len$, i, item;
      if ($scope.demoLoader) {
        for (i$ = 0, len$ = (ref$ = $scope.demoLoader.vars).length; i$ < len$; ++i$) {
          i = i$;
          item = ref$[i$];
          $scope.build["c" + (i + 1)] = item['default'];
        }
        if (!$scope.aniTimer) {
          return $scope.aniTimer = $timeout(function(){
            $scope.demoLoader.start();
            return $interval(function(){
              if (!$scope.build.making) {
                $scope.demoLoader.step($scope.delay);
                if ($scope.build.running) {
                  return $scope.delay = ($scope.delay + $scope.delta) % 1000;
                }
              }
            }, 30);
          }, 1000);
        }
      }
    });
    $scope.build = {
      size: 60,
      running: true,
      making: false,
      done: false,
      speed: 1,
      start: function(){
        return this.running = true;
      },
      stop: function(){
        return this.running = false;
      },
      resize: function(e){
        var total, ref$, ref1$;
        total = 200;
        return this.size = parseInt(100 * ((ref$ = (ref1$ = e.offsetX) > 50 ? ref1$ : 50) < 200 ? ref$ : 200) / (total != null ? total : 200));
      },
      makesvg: function(){
        var type;
        type = $scope.demoLoader.type;
        return $http.get("/static/html/" + type + ".svg.html").success(function(rawSvg){
          var svg;
          rawSvg = '<?xml version="1.0" encoding="utf-8"?>' + rawSvg;
          svg = $scope.demoLoader.patchSvg(rawSvg, $scope.build);
          return outputmodal.create($(svg), new Blob([svg], {
            type: 'text/html'
          }), type, 'SVG');
        });
      },
      makecss: function(){
        var type;
        type = $scope.demoLoader.type;
        return $http.get("/static/html/" + type + ".css.html").success(function(rawHtml){
          return $http.get("/static/css/" + type + ".css").success(function(rawCss){
            var data;
            data = "<style type='text/css'> " + rawCss + " </style> " + rawHtml;
            data = $scope.demoLoader.patchCss(data, $scope.build);
            return outputmodal.create($(data), new Blob([data], {
              type: 'text/html'
            }), type, 'CSS');
          });
        });
      },
      makegif: function(){
        var this$ = this;
        this.done = false;
        this.making = true;
        this.stop();
        return capture($scope.demoLoader, $scope.delta, function(img, blob, type){
          outputmodal.create(img, blob, type, 'GIF');
          return this$.done = true, this$.making = false, this$;
        });
      }
    };
    $('.ttn').tooltip();
    return $timeout(function(){
      var type, mod, e, customVars, res$, i$, ref$, len$, i, v, defaultVars, customStyle, html;
      type = ['default', 'infinity', 'ellipsis'][parseInt(Math.random() * 3)];
      console.log(type);
      try {
        mod = $injector.get("uilType-" + type);
      } catch (e$) {
        e = e$;
        return console.log("module not found.");
      }
      res$ = [];
      for (i$ = 0, len$ = (ref$ = mod.vars).length; i$ < len$; ++i$) {
        i = i$;
        v = ref$[i$];
        res$.push(v.attr + "='{{build.c" + (i + 1) + "}}'");
      }
      customVars = res$;
      defaultVars = ["type='" + type + "'", "background='build.cbk'", "js", "ng-model='demoLoader'"];
      customStyle = ['style="', "width:{{build.size * 2}}px", "height:{{build.size * 2}}px", "margin:{{100 - build.size}}px", '"'].join(";");
      html = $("<uiload " + (customVars.concat(defaultVars, [customStyle])).join(' ') + ">");
      $('#demo-panel').html("");
      return $('#demo-panel').append($compile(html)($scope));
    }, 0);
  }));
  return angular.bootstrap($("body"), ['main']);
});
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}