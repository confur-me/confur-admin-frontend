'use strict'


$ = require('jquery')
_ = require('lodash')

module.exports = ($document) ->
  restrict: 'A'
  scope:
    ngAutocomplete: '=',
  link: (scope, element, attributes) ->
    $document.ready ->
      $(element).checkbox()
    element.bind 'change', (changeEvent) ->
      scope.$apply ->
        scope.ngCheckbox = !scope.ngCheckbox

# Autocomplete
#
# scope method to return tags list by query
# query input on keypress make search, show dropdown list
# click on the list -> select tag, remove it from
# further searches, clear query
