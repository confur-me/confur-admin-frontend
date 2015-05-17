'use strict'

$ = require('jquery')

module.exports = ($document) ->
  restrict: 'A'
  scope:
    ngCheckbox: '=',
  link: (scope, element, attributes) ->
    $document.ready ->
      $(element).checkbox()
    element.bind 'change', (changeEvent) ->
      scope.$apply ->
        scope.ngCheckbox = !scope.ngCheckbox
