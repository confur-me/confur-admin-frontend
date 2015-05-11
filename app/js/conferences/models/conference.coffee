'use strict'

module.exports = ($resource) ->

  Conference = $resource('/api/conferences/:Slug', { Slug: '@Slug' },
    update: { method: 'PUT' },
    save: { method: 'POST', url: '/api/conferences' }
  )
  # TODO: if slug is presend in Create, trying to POST to conferences/slug, which is wrong

  Conference.all = ->
    Conference.query()


  Conference.find = (slug) ->
    conferences = Conference.all()
    conferences.resolve ->
      _.select(conferences, (c) -> c.Slug == slug)[0]

  Conference
