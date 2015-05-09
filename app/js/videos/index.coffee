'use strict'

App = require('angular')
  .module('confur')
  .controller('VideosCtrl', require('./controllers/videos'))
  .factory('Video', require('./models/video'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/videos',
      templateUrl: '/templates/videos/index.html'
      controller: 'VideosCtrl'

    $routeProvider.when '/videos/:id',
      templateUrl: '/templates/videos/show.html'
      controller: 'VideosCtrl'

    $routeProvider.when '/videos/:id/edit',
      templateUrl: '/templates/videos/edit.html'
      controller: 'VideosCtrl'

    $routeProvider.when '/videos/new',
      templateUrl: '/templates/videos/new.html'
      controller: 'VideosCtrl'
  ]
