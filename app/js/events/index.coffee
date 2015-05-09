'use strict'

App = require('angular')
  .module('confur')
  .controller('EventsCtrl', require('./controllers/events'))
  .factory('Event', require('./models/event'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/events',
      templateUrl: '/templates/events/index.html'
      controller: 'EventsCtrl'

    $routeProvider.when '/events/:id',
      templateUrl: '/templates/events/show.html'
      controller: 'EventsCtrl'

    $routeProvider.when '/events/:id/edit',
      templateUrl: '/templates/events/edit.html'
      controller: 'EventsCtrl'

    $routeProvider.when '/events/new',
      templateUrl: '/templates/events/new.html'
      controller: 'EventsCtrl'
  ]
