'use strict'

module.exports = ($resource) ->

  VideoSource =
    $resource '/api/video_sources/:id', id: '@id',
      byEvent:
        url: '/api/events/:event_id/video_sources'
        isArray: true
        method: 'GET'
        params:
          event_id: '@event_id'
      byConference:
        url: '/api/conferences/:conference_slug/video_sources'
        isArray: true
        method: 'GET'
        params:
          conference_slug: '@conference_slug'
      update:
        method: 'PUT'
      sync:
        method: 'POST'
        url: '/api/video_sources/:id/sync'
        params:
          id: '@id'

  VideoSource::isPersistent = ->
    !!@id

  VideoSource
