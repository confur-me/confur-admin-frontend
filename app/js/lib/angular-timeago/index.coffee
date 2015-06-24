'use strict'

Timeago = require('timeago')
Angular = require('angular')

Angular
  .module('angularTimeago', [])
  .filter 'timeAgo', -> (date) ->
    return "never" if !date
    Timeago(date)
