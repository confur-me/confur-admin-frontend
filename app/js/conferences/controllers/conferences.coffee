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

  $scope.cancel = ->
    $scope.conference = undefined
    console.log "Cancelled conference"
    console.log $scope.conference
