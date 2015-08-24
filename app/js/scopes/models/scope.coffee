'use strict'

module.exports = ($resource) ->
  Scope =
    $resource '/api/scopes/:slug', slug: '@slug',
      update:
        method: 'PUT'

  Scope
