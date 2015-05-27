'use strict'

module.exports = ($scope, $routeParams, Event, Conference) ->

  if eventId = $routeParams.eventId
    $scope.event = Event.find(eventId)

  $scope.conferences = Conference.query()

  $scope.tab = $routeParams.tab || 'event'

  $scope.save = () ->
    $scope.event.$update().then ->
      $scope.flash = 'Saved successfully'
      #$scope.$location.path('/events/'+$scope.event.Slug)
    , (error) ->
      $scope.error = 'Error'
      $scope.event.error = error.data.error

  $scope.sync = () ->
    $scope.event.$sync()
