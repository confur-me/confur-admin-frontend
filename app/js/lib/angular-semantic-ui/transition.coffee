'use strict'

$ = require('jquery')

module.exports = ($document) ->
  restrict: 'A'
  scope:
    ngTransition: '=',
  link: (scope, element, attributes) ->
    console.log scope.ngTransition
    element.bind 'change', (changeEvent) ->
      console.log "changed"
      $(element).transition(scope.ngTransition)
