'use strict'

App = require('angular')
  .module('confur')
  .controller('ConferencesCtrl', require('./controllers/conferences'))
  .factory('Conference', require('./models/conference'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/conferences',
      templateUrl: '/templates/conferences/index.html'
      controller: 'ConferencesCtrl'

    $routeProvider.when '/conferences/:id',
      templateUrl: '/templates/conferences/show.html'
      controller: 'ConferencesCtrl'

    $routeProvider.when '/conferences/:id/edit',
      templateUrl: '/templates/conferences/edit.html'
      controller: 'ConferencesCtrl'

    $routeProvider.when '/conferences/new',
      templateUrl: '/templates/conferences/new.html'
      controller: 'ConferencesCtrl'
  ]
