'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, Conference) ->

  $scope.conferenceTypes = [
    'meetup', 'conference', 'lecture'
  ]

  $scope.conferences = Conference.all()

  if conferenceSlug = $routeParams.conferenceSlug
    $scope.conference = Conference.get({Slug: conferenceSlug})
  else if $scope.$location.path() == '/conferences/new'
    $scope.conference = new Conference({})

  $scope.destroy = (conference) ->
    conference.$delete().then ->
      $scope.conferences = _.without $scope.conferences, conference

  $scope.save = () ->
    if $scope.conference.ID
      $scope.conference.$update().then ->
        $scope.$location.path('/conferences')
      , (error) ->
        $scope.conference.error = error.data.error
    else
      $scope.conference.$save().then ->

        $scope.$location.path('/conferences')
      , (error) ->
        $scope.conference.error = error.data.error
