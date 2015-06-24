'use strict'

_ = require('lodash')

module.exports = ($scope, Conference) ->
  Conference.query().$promise.then (confs) ->
    $scope.conferences = confs

  $scope.sync = (slug) ->
    conf = _.find $scope.conferences, (src) ->
      src.slug == slug
    if conf
      conf.$sync()

  $scope.destroy = (slug) ->
    conference = _.find $scope.conferences, (src) ->
      src.slug == slug
    return unless conference
    conference.$delete().then ->
      conference.deleted_at = new Date()
      $scope.flash = 'Deleted successfully'

  $scope.restore = (slug) ->
    conference = _.find $scope.conferences, (src) ->
      src.slug == slug
    return unless conference
    conference.$restore().then ->
      conference.deleted_at = null
      $scope.flash = 'Restored successfully'
