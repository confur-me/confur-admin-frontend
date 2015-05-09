'use strict'

module.exports = ($resource, data) ->

  Video = $resource("/videos/:id.json", { id: '@id' },
    update: { method: 'PUT' }
  )

  Video.all = ->
    Video.query()

  Video
