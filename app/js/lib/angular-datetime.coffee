'use strict'

Angular = require('angular')

Angular
  .module('angularDatetime', [])
  .filter 'time', -> (date) ->
    newDate = Date new(date)
    console.log newDate

Angular
  .module('angularDatetime', [])
  .filter 'date', -> (date) ->
    newDate = Date new(date)
    console.log newDate
