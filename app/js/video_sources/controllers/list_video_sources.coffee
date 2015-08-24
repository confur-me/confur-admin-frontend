'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, $timeout, VideoSource, Setting, Tag) ->

  $scope.locationTypes = {}
  $scope.services = []
  $scope.autocomplete = {}
  $scope.videoSource = null
  $scope.syncingSources = []

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

  $scope.add = ->
    $scope.cancel()
    conferenceSlug =
      if $routeParams.conferenceSlug
        parseInt($routeParams.conferenceSlug, 10)
      else
        $scope.conference?.slug || $scope.event?.conference_slug
    eventId =
      if $routeParams.eventId
        parseInt($routeParams.eventId, 10)
      else
        $scope.event?.id
    scope =
      $scope.event?.scope ||
      $scope.conference?.scope
    $scope.videoSource =
      new VideoSource
        is_active: true
        conference_slug: conferenceSlug
        event_id: eventId
        scope: scope

  $scope.edit = (id) ->
    $scope.cancel()
    index = _.findIndex $scope.videoSources, (src) ->
      src.id == id
    $scope.videoSource = angular.copy($scope.videoSources[index])
    $scope.videoSource.init()

  $scope.sync = (id) ->
    source = _.find $scope.videoSources, (src) ->
      src.id == id
    if source
      source.$sync().then ->
        source.syncing = true
        $scope.syncingSources.push source.id

  $scope.save = ->
    $scope.videoSource.combineTags()
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

  $scope.$watch 'autocomplete.tagQuery', (q) ->
    $scope.autocomplete.tags = []
    if q?.length > 0
      Tag.search({q: q}).$promise.then (tags) ->
        # TODO: refactor
        _.each tags, (tag) ->
          unless _.include $scope.videoSource.tags, tag.slug
            $scope.autocomplete.tags.push tag

  $scope.addTag = (tag) ->
    if $scope.videoSource
      $scope.videoSource.tags ||= []
      $scope.videoSource.tags.push tag
    resetAutocomplete()

  $scope.removeTag = (tag) ->
    if $scope.videoSource
      $scope.videoSource.tags ||= []
      $scope.videoSource.tags = _.without($scope.videoSource.tags, tag)

  resetAutocomplete = ->
    $scope.autocomplete = {}
