'use strict'

module.exports = ($scope, $routeParams, Video) ->
  $scope.videos =
    Video.query
      ConferenceSlug: $routeParams.conferenceSlug
