'use strict'

App = require('angular')
  .module('confur')
  .factory('Setting', require('../settings/models/setting'))
  .factory('Tag', require('./models/tag'))
  .factory('Video', require('../videos/models/video'))
  .controller('ListTagsCtrl', require('./controllers/list_tags'))
  .controller('NewTagCtrl', require('./controllers/new_tag'))
  .controller('EditTagCtrl', require('./controllers/edit_tag'))
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    $routeProvider.when '/tags',
      templateUrl: '/templates/tags/index.html'
      controller: 'ListTagsCtrl'

    $routeProvider.when '/tags/new',
      templateUrl: '/templates/tags/edit.html'
      controller: 'NewTagCtrl'

    $routeProvider.when '/tags/:tagSlug',
      templateUrl: '/templates/tags/edit.html'
      controller: 'EditTagCtrl'
  ]
