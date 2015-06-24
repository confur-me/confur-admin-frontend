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

  Tag
