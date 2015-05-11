'use strict'

module.exports = ($scope, $route, $routeParams, $location) ->
  $scope.$loading = true
  $scope.$route = $route
  $scope.$location = $location
  $scope.$routeParams = $routeParams
  console.log 'Main ctrl'
