'use strict'

module.exports = ($resource) ->

  Conference = $resource('/api/conferences/:slug', { slug: '@Slug' },
    update: { method: 'PUT' },
    save: { method: 'POST', url: '/api/conferences' }
  )

  Conference.all = ->
    Conference.query()

  Conference.find = (slug) ->
    Conference.get({slug: slug})

  Conference
