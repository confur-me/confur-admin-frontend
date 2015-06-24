'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, $q, Event, Conference) ->

  if eventId = $routeParams.eventId
    $scope.event = _.tap Event.find(eventId), (event) ->
      event.init()

  $scope.conferences = Conference.query()

  $q.all([$scope.event.$promise, $scope.conferences.$promise ]).then ->
    $scope.event.conference = _.find $scope.conferences, (conference) ->
      conference.slug == $scope.event.conference_slug
    $scope.event.conference_slug = $scope.event.conference.slug + ""

  $scope.tab = $routeParams.tab || 'event'

  $scope.save = ->
    $scope.event.combineDateTime()
    $scope.event.$update().then ->
      $scope.flash = 'Saved successfully'
    , (error) ->
      $scope.error = 'Error'
      $scope.event.error = error.data.error

  $scope.sync = () ->
    $scope.event.$sync()
