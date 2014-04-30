<- define <[]>
angular.module \uiloading
  ..factory \uilType-blank, ($interval, uilresize) ->
    start = null
    ret = do
      mode: \both
      vars: 
        * name: 'name1', placeholder: '#f00', type: 'color', default: '#000', attr: 'name1'
        * name: 'name2', placeholder: '5', type: 'px', default: '5', attr: 'name2'
        * name: 'name3', placeholder: '#f00', type: 'color', default: '#000', attr: 'name3'
      patch-css: (data, opt) -> @patch data, opt
      patch-svg: (data, opt) -> @patch data, opt
      patch: (data, opt) -> data
      custom: (s, e, a, c) ->
      start: (s, e, a, c) ->
      stop: (s, e, a, c) ->
      step: (s, e, a, c, delay) ->
