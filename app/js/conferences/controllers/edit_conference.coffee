'use strict'

module.exports = ($scope, $routeParams, Conference) ->

  $scope.conferenceTypes = [
    'meetup', 'conference', 'lecture'
  ]

  if conferenceSlug = $routeParams.conferenceSlug
    $scope.conference = Conference.get({Slug: conferenceSlug})

  $scope.save = () ->
    $scope.conference.$update().then ->
      $scope.$location.path('/conferences')
    , (error) ->
      $scope.conference.error = error.data.error
