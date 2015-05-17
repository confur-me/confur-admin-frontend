'use strict'

module.exports = ($resource) ->

  Conference =
    $resource '/api/conferences/:Slug',
      Slug: '@Slug'
    ,
      update:
        method: 'PUT'
      save:
        method: 'POST'
        url: '/api/conferences'
      sync:
        method: 'POST'
        url: '/api/conferences/:Slug/sync'

  Conference::isPersistent = ->
    !!@UpdatedAt

  Conference.find = (slug) ->
    Conference.get({Slug: slug})

  Conference
