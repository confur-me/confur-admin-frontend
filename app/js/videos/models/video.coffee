'use strict'

module.exports = ($resource) ->
  Video =
    $resource '/api/videos/:id',
      id: '@id'
    ,
      update:
        method: 'PUT'
      byConference:
        method: 'GET'
        isArray: true
        url: '/api/conferences/:conference_slug/videos'
        params:
          conference_slug: '@conference_slug'

  Video.find = (id) ->
    Video.get({id: id})

  Video
