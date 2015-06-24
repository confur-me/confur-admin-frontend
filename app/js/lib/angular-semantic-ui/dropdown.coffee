'use strict'

$ = require('jquery')

module.exports = ($document, $timeout) ->
  restrict: 'A'
  scope:
    uiDropdown: '='
  link: (scope, element, attributes) ->
    $document.ready ->
      $timeout ->
        $(element)
          .dropdown
            #onChange: (text, value, $selectedItem) ->
              #scope.$apply ->
                #scope.ngDropdown = value
            #onShow:
        #console.log $(element).dropdown('set selected', scope.ngDropdown)
        #console.log $(element).dropdown('get value') ->
      , 400 # FIXME: fucking dirty hack!
