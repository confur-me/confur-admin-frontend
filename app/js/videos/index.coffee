'use strict'

App = require('angular')
  .module('confur')
  .factory('Setting', require('../settings/models/setting'))
  .factory('Video', require('./models/video'))
  .factory('Tag', require('../tags/models/tag'))
  .controller('VideosCtrl', require('./controllers/list'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/videos',
      templateUrl: '/templates/videos/list.html'
      controller: 'VideosCtrl'
  ]
