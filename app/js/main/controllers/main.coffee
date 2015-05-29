'use strict'

module.exports = ($scope, $route, $routeParams, $location) ->
  $scope.$route = $route
  $scope.$location = $location
  $scope.$routeParams = $routeParams
  $scope.$flash = null
  $scope.$error = null
  console.log 'Main ctrl'
