'use strict'

module.exports = ($resource) ->

  Conference =
    $resource '/api/conferences/:slug',
      slug: '@slug'
    ,
      update:
        method: 'PUT'
      save:
        method: 'POST'
        url: '/api/conferences'
      sync:
        method: 'POST'
        url: '/api/conferences/:slug/sync'
      restore:
        method: 'POST'
        url: '/api/conferences/:slug/restore'

  Conference::isPersistent = ->
    !!@updated_at

  Conference.find = (slug) ->
    Conference.get({slug: slug})

  Conference
