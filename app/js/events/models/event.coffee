'use strict'

module.exports = ($resource) ->
  Event =
    $resource '/api/events/:id',
      id: '@id'
    ,
      update:
        method: 'PUT'
      byConference:
        method: 'GET'
        isArray: true
        url: '/api/conferences/:conference_slug/events'
        params:
          conference_slug: '@conference_slug'

  Event.find = (id) ->
    Event.get({id: id})

  Event

