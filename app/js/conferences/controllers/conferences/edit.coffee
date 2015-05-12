'use strict'

module.exports = ($scope, $routeParams, Conference) ->

  $scope.conferenceTypes = [
    'meetup', 'conference', 'lecture'
  ]

  if conferenceSlug = $routeParams.conferenceSlug
    $scope.conference = Conference.find(conferenceSlug)

  $scope.tab = $routeParams.tab || 'conference'

  $scope.save = () ->
    $scope.conference.$update().then ->
      $scope.$location.path('/conferences')
    , (error) ->
      $scope.conference.error = error.data.error
