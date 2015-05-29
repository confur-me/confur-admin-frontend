'use strict'

module.exports = ($scope, $routeParams, Conference, Setting) ->
  Setting.get('conference.types').then (value) ->
    $scope.conferenceTypes = (value || "").split(',')

  if conferenceSlug = $routeParams.conferenceSlug
    $scope.conference = Conference.find(conferenceSlug)

  $scope.tab = $routeParams.tab || 'conference'

  $scope.save = () ->
    $scope.conference.$update().then ->
      $scope.flash = 'Saved successfully'
      #$scope.$location.path('/conferences/'+$scope.conference.Slug)
    , (error) ->
      $scope.error = 'Error'
      $scope.conference.error = error.data.error

  $scope.sync = () ->
    $scope.conference.$sync()
