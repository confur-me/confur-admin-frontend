'use strict'

module.exports = ($resource, data) ->

  Event = $resource("/events/:id.json", { id: '@id' },
    update: { method: 'PUT' }
  )

  Event.all = ->
    Event.query()

  Event
