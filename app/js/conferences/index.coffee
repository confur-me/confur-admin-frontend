'use strict'

App = require('angular')
  .module('confur')
  .controller('ConferencesCtrl', require('./controllers/conferences'))
  .factory('Conference', require('./models/conference'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/conferences',
      templateUrl: '/templates/conferences/index.html'
      controller: 'ConferencesCtrl'

    $routeProvider.when '/conferences/new',
      templateUrl: '/templates/conferences/form.html'
      controller: 'ConferencesCtrl'

    $routeProvider.when '/conferences/:conferenceSlug',
      templateUrl: '/templates/conferences/form.html'
      controller: 'ConferencesCtrl'
  ]
