'use strict'

App = require('angular')
  .module('confur')
  .factory('Video', require('./models/video'))
  .controller('VideosCtrl', require('./controllers/list'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/videos',
      templateUrl: '/templates/videos/list.html'
      controller: 'VideosCtrl'
  ]
