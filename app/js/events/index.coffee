'use strict'

App = require('angular')
  .module('confur')
  .controller('ListEventsCtrl', require('./controllers/list_events'))
  .controller('NewEventCtrl', require('./controllers/new_event'))
  .controller('EditEventCtrl', require('./controllers/edit_event'))
  .factory('Event', require('./models/event'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/events',
      templateUrl: '/templates/events/index.html'
      controller: 'ListEventsCtrl'

    $routeProvider.when '/events/new',
      templateUrl: '/templates/events/edit.html'
      controller: 'NewEventCtrl'

    $routeProvider.when '/events/:eventId',
      templateUrl: '/templates/events/edit.html'
      controller: 'EditEventCtrl'

    $routeProvider.when '/conferences/:conferenceSlug/events/new',
      templateUrl: '/templates/events/edit.html'
      controller: 'NewEventCtrl'
  ]
