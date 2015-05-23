'use strict'

module.exports = ($scope, $routeParams, Event) ->
  $scope.events =
    if $routeParams.conferenceSlug
      Event.byConference
        ConferenceSlug: $routeParams.conferenceSlug
    else
      Event.query()

  $scope.sync = (id) ->
    conf = _.find $scope.events, (src) ->
      src.ID == id
    if conf
      conf.$sync()
