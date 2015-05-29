'use strict'

App = require('angular')
  .module('confur')
  .factory('Setting', require('../settings/models/setting'))
  .controller('MainCtrl', require('./controllers/main'))
