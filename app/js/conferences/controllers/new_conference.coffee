'use strict'

module.exports = ($scope, $routeParams, Conference, Setting) ->
  Setting.get('conference.types').then (value) ->
    $scope.conferenceTypes = (value || "").split(',')

  $scope.conference = new Conference

  $scope.tab = $routeParams.tab || 'conference'

  $scope.save = ->
    $scope.conference.$save().then ->
      $scope.$location.path('/conferences/'+$scope.conference.slug)
      $scope.flash = 'SUCCESS'
    , (error) ->
      $scope.error = 'ERROR'
      $scope.conference.error = error.data.error
