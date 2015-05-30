'use strict'

module.exports = ($scope, $routeParams, Video) ->
  $scope.videos =
    if $routeParams.conferenceSlug
      Video.byConference
        conference_slug: $routeParams.conferenceSlug
    else if $routeParams.eventId
      Video.byEvent
        event_id: $routeParams.eventId
    else if $routeParams.tag
      Video.byTag
        Tag: $routeParams.tag
    else
      Video.query()
