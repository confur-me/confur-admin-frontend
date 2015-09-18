'use strict'

App = require('angular')
  .module('confur')
  .factory('Setting', require('../settings/models/setting'))
  .factory('Event', require('./models/event'))
  .factory('VideoSource', require('../video_sources/models/video_source'))
  .factory('Video', require('../videos/models/video'))
  .controller('IndexEventsCtrl', require('./controllers/index_events'))
  .controller('ListEventsCtrl', require('./controllers/list_events'))
  .controller('NewEventCtrl', require('./controllers/new_event'))
  .controller('EditEventCtrl', require('./controllers/edit_event'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/events',
      templateUrl: '/templates/events/index.html'
      controller: 'IndexEventsCtrl'

    $routeProvider.when '/events/new',
      templateUrl: '/templates/events/edit.html'
      controller: 'NewEventCtrl'

    $routeProvider.when '/events/:eventId',
      templateUrl: '/templates/events/edit.html'
      controller: 'EditEventCtrl'

    $routeProvider.when '/events/:eventId/:tab',
      templateUrl: '/templates/events/edit.html'
      controller: 'EditEventCtrl'

    $routeProvider.when '/conferences/:conferenceSlug/events/new',
      templateUrl: '/templates/events/edit.html'
      controller: 'NewEventCtrl'
  ]
