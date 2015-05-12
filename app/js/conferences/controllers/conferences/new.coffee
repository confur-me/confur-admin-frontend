'use strict'

module.exports = ($scope, $routeParams, Conference) ->

  $scope.conferenceTypes = [
    'meetup', 'conference', 'lecture'
  ]

  $scope.conference = new Conference({})

  $scope.tab = $routeParams.tab || 'conference'

  $scope.save = () ->
    $scope.conference.$save().then ->
      $scope.$location.path('/conferences/'+$scope.conference.Slug)
    , (error) ->
      $scope.conference.error = error.data.error
