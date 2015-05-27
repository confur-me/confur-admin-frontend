'use strict'

module.exports = ($scope, $routeParams, Event, Conference) ->

  $scope.event =
    if $routeParams.conferenceSlug
      new Event(conference_slug: $routeParams.conferenceSlug)
    else
      new Event({})

  $scope.conferences = Conference.query()

  $scope.tab = $routeParams.tab || 'event'

  $scope.save = ->
    $scope.event.$save().then ->
      $scope.$location.path('/events/'+$scope.event.slug)
      $scope.flash = 'SUCCESS'
    , (error) ->
      $scope.error = 'ERROR'
      $scope.event.error = error.data.error
