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
      restore:
        method: 'POST'
        url: '/api/events/:id/restore'

  Event::init = ->
    @parseStartsAt()

  Event::isPersistent = ->
    !!@id

  Event::parseStartsAt = ->
    @starts_at_date = @starts_at_time = new Date(@starts_at)

  Event::combineDateTime = ->
    if @starts_at_date
      @starts_at = new Date(@starts_at_date)
      if @starts_at_time
        @starts_at.setHours(@starts_at_time.getHours())
        @starts_at.setMinutes(@starts_at_time.getMinutes())
    console.log @

  Event.find = (id) ->
    Event.get({id: id})

  Event

