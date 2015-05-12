'use strict'

module.exports = ($resource) ->

  VideoSource = $resource('/api/conferences/:conference_id/video_sources/:id', { id: '@ID', conference_id: '@ConferenceID' },
    update: { method: 'PUT' }
  )

  VideoSource.all = ->
    VideoSource.query()

  VideoSource.find = (id) ->
    VideoSource.get({ID: id})

  VideoSource.findByConferenceSlug = (slug) ->
    VideoSource.query({conference_id: slug})

  VideoSource
