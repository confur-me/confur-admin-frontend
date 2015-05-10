'use strict'

module.exports = ($resource) ->

  Conference = $resource("/api/conferences/:Slug", { Slug: '@Slug' },
    update: { method: 'PUT' }
  )

  Conference.all = ->
    # TODO: time cache
    Conference.query()


  Conference.find = (slug) ->
    conferences = Conference.all()
    conferences.resolve ->
      _.select(conferences, (c) -> c.Slug == slug)[0]

  Conference
