<- define <[]>
angular.module \uiloading
  ..factory \uilType-blank, ($interval) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'name1', placeholder: '#f00', type: 'color', default: '#000'
        * name: 'name2', placeholder: '5', type: 'number', default: '5'
        * name: 'name3', placeholder: '#f00', type: 'color', default: '#000'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) -> data
      custom: (s, e, a, c) ->
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
