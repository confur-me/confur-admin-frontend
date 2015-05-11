'use strict'

_ = require('lodash')

module.exports = ($scope, $routeParams, Conference) ->

  $scope.conferenceTypes = [
    'meetup', 'conference', 'lecture'
  ]

  $scope.conference = new Conference({})

  $scope.save = () ->
    $scope.conference.$save().then ->

      $scope.$location.path('/conferences')
    , (error) ->
      $scope.conference.error = error.data.error
