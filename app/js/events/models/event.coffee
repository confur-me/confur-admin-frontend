'use strict'

module.exports = ($resource) ->
  Event =
    $resource '/api/events/:ID',
      ID: '@ID'
    ,
      update:
        method: 'PUT'
      byConference:
        method: 'GET'
        isArray: true
        url: '/api/conferences/:ConferenceSlug/events'
        params:
          ConferenceSlug: '@ConferenceSlug'

  Event.find = (id) ->
    Event.get({ID: id})

  Event

