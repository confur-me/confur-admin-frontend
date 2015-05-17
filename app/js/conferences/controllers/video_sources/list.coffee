'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, VideoSource) ->
  $scope.Services = ['youtube']
  $scope.LocationTypes =
    youtube: ['playlist', 'channel', 'video']

  $scope.videoSources =
    VideoSource.query
      ConferenceSlug: $routeParams.conferenceSlug

  $scope.videoSource = null

  $scope.add = ->
    resetForm()
    $scope.videoSource =
      new VideoSource
        IsActive: true
        LocationType: 'youtube'
        ConferenceSlug: $routeParams.conferenceSlug

  $scope.edit = (id) ->
    resetForm()
    index = _.findIndex $scope.videoSources, (src) ->
      src.ID == id
    $scope.videoSource = angular.copy($scope.videoSources[index])

  $scope.sync = (id) ->
    source = _.find $scope.videoSources, (src) ->
      src.ID == id
    if source
      source.$sync().then ->
        source.$syncing = true

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
      src.ID == $scope.videoSource.ID
    if index > -1
      $scope.videoSources[index] = $scope.videoSource
    else
      $scope.videoSources.push $scope.videoSource
    console.log $scope.videoSources.length

  resetForm = ->
    if $scope.videoSource
      $scope.cancel()
