'use strict'

module.exports = ($scope) ->
  $scope.clicked = 0

  $scope.click = ->
    $scope.clicked += 1
