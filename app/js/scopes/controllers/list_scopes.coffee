'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, $timeout, Scope, Setting) ->

  $scope.scopes = Scope.query()
  $scope.scope = null

  $scope.add = ->
    $scope.cancel()
    $scope.scope = new Scope(is_active: true)

  $scope.edit = (id) ->
    $scope.cancel()
    index = _.findIndex $scope.scopes, (src) ->
      src.id == id
    $scope.scope = angular.copy($scope.scopes[index])

  $scope.save = ->
    if $scope.scope.isPersistent()
      $scope.scope.$update().then ->
        updateCollection()
        $scope.cancel()
      , (error) ->
        $scope.scope.$error = true
    else
      $scope.scope.$save().then ->
        updateCollection()
        $scope.cancel()
      , (error) ->
        $scope.scope.$error = true

  $scope.cancel = ->
    $scope.scope = null

  $scope.destroy = () ->
    $scope.scope.$delete().then ->
      $scope.cancel()
    , (error) ->
      $scope.scope.error = error.data.error
      updateCollection()

  updateCollection = ->
    index = _.findIndex $scope.scopes, (src) ->
      src.id == $scope.scope.id
    if index > -1
      $scope.scopes[index] = $scope.scope
    else
      $scope.scopes.push $scope.scope
