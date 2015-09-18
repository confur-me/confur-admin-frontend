'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, Event) ->
  $scope.events =
    if $routeParams.conferenceSlug
      Event.byConference
        conference_slug: $routeParams.conferenceSlug
    else
      Event.query()

  $scope.search = (query) ->
    $scope.events =
      if $routeParams.conferenceSlug
        Event.byConference
          conference_slug: $routeParams.conferenceSlug
          q: query
      else
        Event.query(q: query)

  $scope.linkToNewEvent =
    if $routeParams.conferenceSlug
      '/conferences/'+$routeParams.conferenceSlug+'/events/new'
    else
      '/events/new'

  $scope.sync = (id) ->
    conf = _.find $scope.events, (src) ->
      src.id == id
    if conf
      conf.$sync()

  $scope.destroy = (id) ->
    event = _.find $scope.events, (src) ->
      src.id == id
    return unless event
    event.$delete().then ->
      event.deleted_at = new Date()
      $scope.flash = 'Deleted successfully'

  $scope.restore = (id) ->
    event = _.find $scope.events, (src) ->
      src.id == id
    return unless event
    event.$restore().then ->
      event.deleted_at = null
      $scope.flash = 'Restored successfully'
