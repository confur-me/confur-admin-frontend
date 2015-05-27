'use strict'

_ = require('lodash')

module.exports = ($scope, Conference) ->
  Conference.query({}, then (confs) ->
    $scope.conferences = confs
  )

  $scope.sync = (slug) ->
    conf = _.find $scope.conferences, (src) ->
      src.slug == slug
    if conf
      conf.$sync()
