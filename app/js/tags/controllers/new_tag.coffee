'use strict'

module.exports = ($scope, $routeParams, Tag) ->
  defaultParams = {}

  $scope.tag = new Tag(defaultParams)

  $scope.tab = $routeParams.tab || 'tag'

  $scope.save = ->
    $scope.tag.$save().then ->
      $scope.$location.path(tagPath($scope.tag))
      $scope.flash = 'SUCCESS'
    , (error) ->
      $scope.error = 'ERROR'
      $scope.tag.error = error.data.error


  tagPath = (tag )->
    '/tags/'+tag.slug
