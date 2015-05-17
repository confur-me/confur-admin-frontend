'use strict'

Angular = require('angular')

Angular
  .module('ngSemanticUI', [require('angular-animate')])
  .directive('ngCheckbox', require('./checkbox'))
  .directive('ngDropdown', require('./dropdown'))
  .directive('ngPopup', require('./popup'))
  .directive('video', require('./video'))
  #.directive('ngTransition', require('./transition'))
  #.animation('.slide', [require('./animation')])
