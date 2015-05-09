'use strict'

App = require('angular')
  .module('confur')
  .controller('DashboardCtrl', require('./controllers/dashboard'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->

    $routeProvider.when '/',
      templateUrl: '/templates/dashboard/index.html'
      controller: 'DashboardCtrl'

    $routeProvider.when '/dashboard',
      templateUrl: '/templates/dashboard/index.html'
      controller: 'DashboardCtrl'
  ]
