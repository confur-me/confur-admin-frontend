'use strict'

_ = require('lodash')

module.exports = ($resource, $timeout, $cacheFactory, $q) ->
  Setting =
    $resource '/api/settings/:key',
      key: '@key'
    ,
      update:
        method: 'PUT'
      save:
        url: '/api/settings'
        method: 'POST'

  Setting::isPersistent = ->
    !!@updated_at

  Setting::isChanged = false

  cache = $cacheFactory('settings')
  $refreshing = false

  reloadCache = ->
    console.log "Reloading settings cache"
    $refreshing = true
    cache.removeAll()
    Setting.query({}, then (settings) ->
      _.each settings, (setting) ->
        cache.put(setting.key, setting.value)
      $refreshing = false
    )
    $timeout(reloadCache, 300000)

  reloadCache()

  Setting.reloadCache = ->
    reloadCache()

  Setting.info = ->
    cache.info()

  Setting.get = (key, deferred) ->
    deferred ||= $q.defer()
    if $refreshing == true
      $timeout ->
        Setting.get(key, deferred)
      , 100
    else
      deferred.resolve(cache.get(key))
    deferred.promise

  Setting.isPersistent = ->
    !!@updated_at

  Setting
