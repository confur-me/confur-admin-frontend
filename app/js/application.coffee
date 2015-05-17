'use strict'

$             = require('jquery')
window.jQuery = $

require('./lib/angular-timeago')
require('./lib/angular-truncate')
require('./lib/angular-semantic-ui')

App = require('angular').module('confur', [
  require('angular-resource'),
  require('angular-sanitize'),
  require('angular-route'),
  require('angular-animate'),
  'angularTimeago',
  'angularTruncate',
  'ngSemanticUI'
])

App.config ['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
]

require('./main')
require('./dashboard')
require('./conferences')
require('./events')
#require('./videos')

jQuery ->
  console.log "Page loaded"
