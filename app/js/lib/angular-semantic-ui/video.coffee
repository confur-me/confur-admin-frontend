'use strict'

$ = require('jquery')

module.exports = ($document, $timeout) ->
  restrict: 'A'
  link: (scope, element, attributes) ->
    $document.ready ->
      $timeout ->
        $(element).video()
        #$(element).find('img')
          #dimmer()
          #on: 'hover'
          #id: '5wvd_Qak4Wg'
          #image: 'https://img.youtube.com/vi/5wvd_Qak4Wg/default.jpg'
          #source: 'youtube'
          #on: 'hover'
          #title: 'asd'
          #content: 'asasdsd'
      , 400

