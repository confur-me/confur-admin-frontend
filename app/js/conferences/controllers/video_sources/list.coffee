'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, VideoSource) ->
  $scope.Services = ['youtube']

  $scope.videoSources = VideoSource.findByConferenceSlug($routeParams.conferenceSlug)

  $scope.new = ->
    $scope.videoSources.push(new VideoSource({edit: true}))

  $scope.destroy = (object) ->
    object.$delete().then ->
      $scope.cancel(object)
    , (error) ->
      object.error = error.data.error
      updateCollection(object)

  $scope.save = (object) ->
    object.$update().then ->
      updateCollection(object)
    , (error) ->
      object.error = error.data.error
      updateCollection(object)

  $scope.cancel = (id) ->
    console.log id
    object = angular.copy(_.select($scope.videoSources, (source) -> source.ID == id)[0])
    console.log object
    if object.ID
      object.edit = false
      console.log object
      updateCollection(object)
    else
      $scope.videoSources = _.without $scope.videoSources, object

  updateCollection = (object) ->
    index = _.findIndex($scope.videoSources, { ID: object.ID })
    console.log index
    console.log object
    console.log $scope.videoSources[index]
    $scope.videoSources[index] = object
    console.log $scope.videoSources[index]
