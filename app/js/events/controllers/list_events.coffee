'use strict'

module.exports = ($scope, $routeParams, Event) ->
  $scope.events =
    if $routeParams.conferenceSlug
      Event.byConference
        conference_slug: $routeParams.conferenceSlug
    else
      Event.query()

  $scope.sync = (id) ->
    conf = _.find $scope.events, (src) ->
      src.id == id
    if conf
      conf.$sync()
