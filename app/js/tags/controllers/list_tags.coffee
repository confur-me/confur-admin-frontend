'use strict'

_ = require('lodash')

module.exports = ($scope, Tag) ->
  $scope.tags = Tag.query()

  $scope.search = (query) ->
    $scope.tags = Tag.query(q: query)

  $scope.destroy = (slug) ->
    tag = _.find $scope.tags, (src) ->
      src.slug == slug
    return unless tag
    tag.$delete().then ->
      tag.deleted_at = new Date()
      $scope.flash = 'Deleted successfully'

  $scope.restore = (slug) ->
    tag = _.find $scope.tags, (src) ->
      src.slug == slug
    return unless tag
    tag.$restore().then ->
      tag.deleted_at = null
      $scope.flash = 'Restored successfully'
