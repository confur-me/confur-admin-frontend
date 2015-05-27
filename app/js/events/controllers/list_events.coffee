'use strict'

module.exports = ($scope, $routeParams, Event) ->
  $scope.events =
    if $routeParams.conferenceSlug
      Event.byConference
        conference_slug: $routeParams.conferenceSlug
    else
      Event.query()

  $scope.linkToNewEvent =
    if $routeParams.conferenceSlug
      '/conferences/'+$routeParams.conferenceSlug+'/events/new'
    else
      '/events/new'



  $scope.sync = (id) ->
    conf = _.find $scope.events, (src) ->
      src.id == id
    if conf
      conf.$sync()
