'use strict'

module.exports = ($scope, $routeParams, Conference, Setting, Scope) ->
  Setting.get('conference.types').then (value) ->
    $scope.conferenceTypes = (value || "").split(',')

  $scope.scopes = Scope.query()

  if conferenceSlug = $routeParams.conferenceSlug
    $scope.conference = Conference.find(conferenceSlug)

  $scope.tab = $routeParams.tab || 'conference'

  $scope.save = ->
    $scope.conference.$update().then ->
      $scope.flash = 'Saved successfully'
    , (error) ->
      $scope.error = 'Error'
      $scope.conference.error = error.data.error

  $scope.sync = ->
    $scope.conference.$sync()

  $scope.destroy = ->
    $scope.conference.$delete().then ->
      $scope.$location.path('/conferences')
    , (error) ->
      $scope.conferences.error = error.data.error

  $scope.restore = ->
    $scope.conference.$restore().then ->
      $scope.conference.deleted_at = null
      $scope.flash = 'Restored successfully'
    , (error) ->
      $scope.conferences.error = error.data.error
