'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, Video, Tag, Setting) ->
  Setting.get('video.languages').then (languages) ->
    $scope.Languages = (languages || '').split(',')

  $scope.autocomplete = {}
  $scope.video = null

  $scope.videos =
    if $routeParams.conferenceSlug
      Video.byConference
        conference_slug: $routeParams.conferenceSlug
    else if $routeParams.eventId
      Video.byEvent
        event_id: $routeParams.eventId
    else if $routeParams.tag
      Video.byTag
        Tag: $routeParams.tag
    else
      Video.query()

  $scope.search = (query) ->
    $scope.videos =
      if $routeParams.conferenceSlug
        Video.byConference
          conference_slug: $routeParams.conferenceSlug
          q: query
      else if $routeParams.eventId
        Video.byEvent
          event_id: $routeParams.eventId
          q: query
      else if $routeParams.tag
        Video.byTag
          tag_slug: $routeParams.tagSlug
          q: query
      else
        Video.query(q: query)

  $scope.edit = (id) ->
    $scope.cancel()
    $scope.video = Video.get({id: id})

  $scope.save = ->
    $scope.video.$update().then ->
      updateCollection()
      $scope.cancel()
    , (error) ->
      $scope.video.$error = true

  $scope.cancel = ->
    $scope.video = null
    resetAutocomplete()

  $scope.destroy = (id) ->
    video = _.find $scope.videos, (src) ->
      src.id == id
    return unless video
    video.$delete().then ->
      video.deleted_at = new Date()
      if $scope.video.id == id
        $scope.cancel()

  $scope.restore = (id) ->
    video = _.find $scope.videos, (src) ->
      src.id == id
    return unless video
    video.$restore().then ->
      video.deleted_at = null
      $scope.flash = 'Restored successfully'
      if $scope.video.id == id
        $scope.video.deleted_at = null

  updateCollection = ->
    index = _.findIndex $scope.videos, (src) ->
      src.id == $scope.video.id
    if index > -1
      $scope.videos[index] = $scope.video
    else
      $scope.videos.push $scope.video

  #$scope.suggestedTags = ->
    #return unless $scope.video
    #console.log $scope.video.title
    #tags = _.words $scope.video.title
    #console.log tags
    #console.log $scope.video.tags
    #if $scope.video.tags?.length > 0
      #tags = _.without tags, $scope.video.tags
    #_.shuffle tags

  $scope.$watch 'autocomplete.tagQuery', (q) ->
    $scope.autocomplete.tags = []
    if q?.length > 0
      Tag.search({q: q}).$promise.then (tags) ->
        # TODO: refactor
        _.each tags, (tag) ->
          unless _.include $scope.video.tags, tag.slug
            $scope.autocomplete.tags.push tag

  $scope.addTag = (tag) ->
    if $scope.video
      $scope.video.tags ||= []
      $scope.video.tags.push tag
    resetAutocomplete()

  $scope.removeTag = (tag) ->
    if $scope.video
      $scope.video.tags ||= []
      $scope.video.tags = _.without($scope.video.tags, tag)

  resetAutocomplete = ->
    $scope.autocomplete = {}
