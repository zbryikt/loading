define([], function(){
  var x$;
  x$ = angular.module('uiloading');
  x$.factory('uilType-flip', function($interval){
    var start, ret;
    start = null;
    return ret = {
      mode: 'both',
      vars: [
        {
          name: 'name1',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'name1'
        }, {
          name: 'name2',
          placeholder: '5',
          type: 'px',
          'default': '5',
          attr: 'name2'
        }, {
          name: 'name3',
          placeholder: '#f00',
          type: 'color',
          'default': '#000',
          attr: 'name3'
        }
      ],
      patchCss: function(data, opt){
        return this.patch(data, opt);
      },
      patchSvg: function(data, opt){
        return this.patch(data, opt);
      },
      patch: function(data, opt){
        return data;
      },
      custom: function(s, e, a, c){},
      start: function(s, e, a, c){},
      stop: function(s, e, a, c){},
      step: function(s, e, a, c, delay){}
    };
  });
  return x$;
});
