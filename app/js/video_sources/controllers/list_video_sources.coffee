'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, $timeout, VideoSource) ->
  $scope.Services = ['youtube']
  $scope.LocationTypes =
    youtube: ['playlist', 'channel', 'video']

  VideoSource.query
    conference_slug: $routeParams.conferenceSlug
  , then (sources) ->
    $scope.videoSources = sources
    _.each $scope.videoSources, (src) ->
      if src.syncing
        $scope.syncingSources.push src.id

  $scope.$watchCollection 'syncingSources', ->
    checkSyncing()

  $scope.videoSource = null
  $scope.syncingSources = []

  $scope.add = ->
    resetForm()
    $scope.videoSource =
      new VideoSource
        is_active: true
        location_type: 'youtube'
        conference_slug: $routeParams.conferenceSlug

  $scope.edit = (id) ->
    resetForm()
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
    $scope.videoSource = null

  #$scope.destroy = (videoSource) ->
    #videoSource.$delete().then ->
      #$scope.cancel(videoSource)
    #, (error) ->
      #videoSource.error = error.data.error
      #updateCollection(videoSource)

  updateCollection = ->
    index = _.findIndex $scope.videoSources, (src) ->
      src.id == $scope.videoSource.id
    if index > -1
      $scope.videoSources[index] = $scope.videoSource
    else
      $scope.videoSources.push $scope.videoSource

  resetForm = ->
    if $scope.videoSource
      $scope.cancel()

  checkSyncing = ->
    if _.any($scope.syncingSources)
      VideoSource.query
        conference_slug: $routeParams.conferenceSlug
      , then (newSources) ->
        _.each $scope.syncingSources, (sourceId) ->
          source = _.find newSources, (src) ->
            src.id == sourceId
          unless source && source.syncing
            $scope.syncingSources = _.without($scope.syncingSources, sourceId)
        $scope.videoSources = newSources
      $timeout(checkSyncing, 2000)
