'use strict'

module.exports = ($resource) ->
  Video =
    $resource '/api/conferences/:ConferenceSlug/videos',
      ConferenceSlug: '@ConferenceSlug'
    ,
      update:
        method: 'PUT'

  Video.find = (id) ->
    Video.get({ID: id})

  Video
