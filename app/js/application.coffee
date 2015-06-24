'use strict'

$             = require('jquery')
window.jQuery = $
Angular = require('angular')

require('./lib/angular-timeago')
require('./lib/angular-truncate')
require('./lib/angular-semantic-ui')
require('./lib/angular-datetime')
require('angular-loading-bar')

App = Angular
  .module('confur', [
    require('angular-resource'),
    require('angular-sanitize'),
    require('angular-route'),
    require('angular-animate'),
    'angularTimeago',
    'angularTruncate',
    'ngSemanticUI',
    'angular-loading-bar',
    'angularDatetime'
  ])

App
  .config(['cfpLoadingBarProvider', (cfpLoadingBarProvider) ->
    cfpLoadingBarProvider.latencyThreshold = 0
    cfpLoadingBarProvider.includeSpinner = true
  ])
  .config(['$locationProvider', ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ])

require('./main')
require('./settings')
require('./dashboard')
require('./conferences')
require('./videos')
require('./events')

jQuery ->
  console.log "Page loaded"
