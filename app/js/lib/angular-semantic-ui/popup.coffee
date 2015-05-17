'use strict'

$ = require('jquery')

module.exports = ($document) ->
  restrict: 'A'
  link: (scope, element, attributes) ->
    $document.ready ->
      $(element).popup
        on: 'hover'
        title: 'asd'
        content: 'asasdsd'

