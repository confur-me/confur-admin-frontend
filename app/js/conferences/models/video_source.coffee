'use strict'

module.exports = ($resource) ->

  VideoSource =
    $resource '/api/conferences/:conference_slug/video_sources/:id',
      id: '@id'
      conference_slug: '@conference_slug'
    ,
      update:
        method: 'PUT'
      sync:
        method: 'POST'
        url: '/api/conferences/:conference_slug/video_sources/:id/sync'

  VideoSource::isPersistent = ->
    !!@id

  VideoSource
