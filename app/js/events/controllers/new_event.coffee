'use strict'

module.exports = ($scope, $routeParams, Event, Conference) ->
  defaultParams = { is_active: false }

  $scope.event = new Event(defaultParams)
  if $routeParams.conferenceSlug
    $scope.event.conference_slug = $routeParams.conferenceSlug

  $scope.conferences = Conference.query()

  $scope.tab = $routeParams.tab || 'event'

  $scope.save = ->
    $scope.event.combineDateTime()
    $scope.event.$save().then ->
      $scope.$location.path(eventPath($scope.event))
      $scope.flash = 'SUCCESS'
    , (error) ->
      $scope.error = 'ERROR'
      $scope.event.error = error.data.error


  eventPath = (event )->
    '/events/'+event.id
