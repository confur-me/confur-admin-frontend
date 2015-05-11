'use strict'

$ = require('jquery')
_ = require('lodash')

require('./lib/angular-timeago')

App = require('angular').module('confur', [
  require('angular-resource'),
  require('angular-sanitize'),
  require('angular-route'),
  require('angular-animate'),
  'angularTimeago'
])

App.config ['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
]

require('./main')
require('./dashboard')
require('./conferences')
require('./events')
require('./videos')

$ ->
  console.log "Page loaded"
