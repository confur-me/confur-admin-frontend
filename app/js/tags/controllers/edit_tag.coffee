'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, Tag) ->

  if tagSlug = $routeParams.tagSlug
    $scope.tag = _.tap Tag.find(tagSlug), (tag) ->
      tag.init()

  $scope.tab = $routeParams.tab || 'tag'

  $scope.save = ->
    $scope.tag.$update().then ->
      $scope.flash = 'Saved successfully'
    , (error) ->
      $scope.error = 'Error'
      $scope.tag.error = error.data.error
