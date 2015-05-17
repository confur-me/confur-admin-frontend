'use strict'

module.exports = ($resource) ->
  Video =
    $resource '/api/videos/:ID',
      ID: '@ID'
    ,
      update:
        method: 'PUT'
      byConference:
        method: 'GET'
        isArray: true
        url: '/api/conferences/:ConferenceSlug/videos'
        params:
          ConferenceSlug: '@ConferenceSlug'

  Video.find = (id) ->
    Video.get({ID: id})

  Video
