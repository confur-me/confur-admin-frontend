'use strict'

_ = require('lodash')

module.exports = ($scope, Conference) ->
  $scope.conferences = Conference.query()

  $scope.sync = (slug) ->
    conf = _.find $scope.conferences, (src) ->
      src.Slug == slug
    if conf
      conf.$sync()
