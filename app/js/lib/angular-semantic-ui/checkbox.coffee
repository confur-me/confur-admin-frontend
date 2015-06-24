'use strict'

$ = require('jquery')

module.exports = ($document) ->
  restrict: 'A'
  scope:
    uiCheckbox: '=',
  link: (scope, element, attributes) ->
    $document.ready ->
      $(element).checkbox()
      element.bind 'change', (changeEvent) ->
        scope.$apply ->
          scope.uiCheckbox = !scope.uiCheckbox
