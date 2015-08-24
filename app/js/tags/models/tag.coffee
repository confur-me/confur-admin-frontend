'use strict'

module.exports = ($resource) ->

  Tag =
    $resource '/api/tags/:slug', slug: '@slug',
      search:
        url: '/api/tags'
        isArray: true
        method: 'GET'
      update:
        method: 'PUT'
      save:
        method: 'POST'
        url: '/api/tags'

  Tag::init = ->
    return

  Tag::isPersistent = ->
    !!@created_at

  Tag.find = (slug) ->
    Tag.get(slug: slug)

  Tag
