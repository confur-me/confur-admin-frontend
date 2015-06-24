'use strict'

App = require('angular')
  .module('confur')
  .factory('Setting', require('../settings/models/setting'))
  .factory('Scope', require('../scopes/models/scope'))
  .factory('Conference', require('./models/conference'))
  .factory('VideoSource', require('../video_sources/models/video_source'))
  .factory('Video', require('../videos/models/video'))
  .factory('Event', require('../events/models/event'))
  .controller('ConferencesCtrl', require('./controllers/list_conferences'))
  .controller('NewConferenceCtrl', require('./controllers/new_conference'))
  .controller('EditConferenceCtrl', require('./controllers/edit_conference'))
  .controller('VideoSourcesCtrl', require('../video_sources/controllers/list_video_sources'))
  .controller('VideosCtrl', require('../videos/controllers/list'))
  .controller('ListEventsCtrl', require('../events/controllers/list_events'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/conferences',
      templateUrl: '/templates/conferences/list.html'
      controller: 'ConferencesCtrl'

    $routeProvider.when '/conferences/new',
      templateUrl: '/templates/conferences/form.html'
      controller: 'NewConferenceCtrl'

    $routeProvider.when '/conferences/:conferenceSlug',
      templateUrl: '/templates/conferences/form.html'
      controller: 'EditConferenceCtrl'

    $routeProvider.when '/conferences/:conferenceSlug/:tab',
      templateUrl: '/templates/conferences/form.html'
      controller: 'EditConferenceCtrl'
  ]
