'use strict'

module.exports = ($scope, $routeParams, Video) ->
  $scope.videos =
    if $routeParams.conferenceSlug
      Video.byConference
        ConferenceSlug: $routeParams.conferenceSlug
    else if $routeParams.tag
      Video.byTag
        Tag: $routeParams.tag
    else
      Video.query()
