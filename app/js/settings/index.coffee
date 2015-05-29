'use strict'

App = require('angular')
  .module('confur')
  .factory('Setting', require('./models/setting'))
  .controller('SettingsCtrl', require('./controllers/settings'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/settings',
      templateUrl: '/templates/settings/list.html'
      controller: 'SettingsCtrl'
  ]
