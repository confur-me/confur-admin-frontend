'use strict'

App = require('angular')
  .module('confur')
  .factory('Conference', require('./models/conference'))
  .controller('ConferencesCtrl', require('./controllers/conferences_list'))
  .controller('NewConferenceCtrl', require('./controllers/new_conference'))
  .controller('EditConferenceCtrl', require('./controllers/edit_conference'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/conferences',
      templateUrl: '/templates/conferences/index.html'
      controller: 'ConferencesCtrl'

    $routeProvider.when '/conferences/new',
      templateUrl: '/templates/conferences/form.html'
      controller: 'NewConferenceCtrl'

    $routeProvider.when '/conferences/:conferenceSlug',
      templateUrl: '/templates/conferences/form.html'
      controller: 'EditConferenceCtrl'
  ]
