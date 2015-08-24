'use strict'

module.exports = ($scope, $routeParams, Conference, Setting, Scope) ->
  defaultParams = { is_active: false }

  Setting.get('conference.types').then (value) ->
    $scope.conferenceTypes = (value || "").split(',')

  $scope.scopes = Scope.query()

  $scope.conference = new Conference(defaultParams)

  $scope.tab = $routeParams.tab || 'conference'

  $scope.save = ->
    $scope.conference.$save().then ->
      $scope.$location.path('/conferences/'+$scope.conference.slug)
      $scope.flash = 'SUCCESS'
    , (error) ->
      $scope.error = 'ERROR'
      $scope.conference.error = error.data.error
