'use strict'

$ = require('jquery')
_ = require('lodash')

App = require('angular').module('confur', [
  require('angular-resource'),
  require('angular-sanitize'),
  require('angular-route'),
  require('angular-animate')
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
