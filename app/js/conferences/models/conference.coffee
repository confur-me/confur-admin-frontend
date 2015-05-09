'use strict'

module.exports = ($resource, data) ->

  Conference = $resource("/conferences/:id.json", { id: '@id' },
    update: { method: 'PUT' }
  )

  Conference.all = ->
    Conference.query()

  Conference
