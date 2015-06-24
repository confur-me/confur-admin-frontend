'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, $timeout, VideoSource, Setting) ->

  $scope.locationTypes = {}
  $scope.services = []

  Setting.get('video_source.services').then (services) ->
    $scope.services = (services || '').split(',')
    _.each $scope.services, (service) ->
      Setting.get('services.'+service+'.location_types').then (types) ->
        $scope.locationTypes[service] = (types || '').split(',')

  $scope.videoSources =
    if $routeParams.conferenceSlug
      VideoSource.byConference
        conference_slug: $routeParams.conferenceSlug
    else if $routeParams.eventId
      VideoSource.byEvent
        event_id: $routeParams.eventId
    else
      VideoSource.query()

  $scope.videoSources.$promise.then (sources) ->
    _.each sources, (src) ->
      if src.syncing
        $scope.syncingSources.push src.id

  $scope.$watchCollection 'syncingSources', ->
    checkSyncing()

  $scope.videoSource = null
  $scope.syncingSources = []

  $scope.add = ->
    $scope.cancel()
    conferenceSlug =
      $routeParams.conferenceSlug ||
      conference?.slug ||
      event?.conference_slug
    eventId =
      $routeParams.eventId ||
      event?.id
    $scope.videoSource =
      new VideoSource
        is_active: true
        conference_slug: conferenceSlug
        event_id: eventId

  $scope.edit = (id) ->
    $scope.cancel()
    index = _.findIndex $scope.videoSources, (src) ->
      src.id == id
    $scope.videoSource = angular.copy($scope.videoSources[index])

  $scope.sync = (id) ->
    source = _.find $scope.videoSources, (src) ->
      src.id == id
    if source
      source.$sync().then ->
        source.syncing = true
        $scope.syncingSources.push source.id

  $scope.save = ->
    if $scope.videoSource.isPersistent()
      $scope.videoSource.$update().then ->
        updateCollection()
        $scope.cancel()
      , (error) ->
        $scope.videoSource.$error = true
    else
      $scope.videoSource.$save().then ->
        updateCollection()
        $scope.cancel()
      , (error) ->
        $scope.videoSource.$error = true

  $scope.cancel = ->
    console.log "canceling"
    $scope.videoSource = null

  $scope.destroy = ->
    $scope.videoSource.$delete().then ->
      $scope.cancel()
      updateCollection()
    , (error) ->
      $scope.videoSource.error = error.data.error
      updateCollection()

  updateCollection = ->
    index = _.findIndex $scope.videoSources, (src) ->
      src.id == $scope.videoSource.id
    if index > -1
      $scope.videoSources[index] = $scope.videoSource
    else
      $scope.videoSources.push $scope.videoSource

  checkSyncing = ->
    if _.any($scope.syncingSources)
      if $routeParams.conferenceSlug
        VideoSource.byConference
          conference_slug: $routeParams.conferenceSlug
        , then (sources) ->
          refreshSyncing(sources)
      else if $routeParams.eventId
        VideoSource.byEvent
          event_id: $routeParams.eventId
        , then (sources) ->
          refreshSyncing(sources)
      $timeout(checkSyncing, 2000)

  refreshSyncing = (sources) ->
    _.each $scope.syncingSources, (sourceId) ->
      source = _.find sources, (src) ->
        src.id == sourceId
      unless source && source.syncing
        $scope.syncingSources = _.without($scope.syncingSources, sourceId)
    $scope.videoSources = sources
