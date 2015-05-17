'use strict'

module.exports = ($resource) ->

  VideoSource =
    $resource '/api/conferences/:ConferenceSlug/video_sources/:ID',
      ID: '@ID'
      ConferenceSlug: '@ConferenceSlug'
    ,
      update:
        method: 'PUT'
      sync:
        method: 'POST'
        url: '/api/conferences/:ConferenceSlug/video_sources/:ID/sync'

  VideoSource::isPersistent = ->
    !!@ID

  VideoSource
