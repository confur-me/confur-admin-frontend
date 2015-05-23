'use strict'

App = require('angular')
  .module('confur')
  .controller('ListEventsCtrl', require('./controllers/list_events'))
  .factory('Event', require('./models/event'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/events',
      templateUrl: '/templates/events/index.html'
      controller: 'ListEventsCtrl'

    $routeProvider.when '/events/new',
      templateUrl: '/templates/events/form.html'
      controller: 'NewEventCtrl'

    $routeProvider.when '/events/:id',
      templateUrl: '/templates/events/form.html'
      controller: 'EditEventCtrl'
  ]
