'use strict'

Angular = require('angular')

Angular
  .module('ngSemanticUI', [require('angular-animate')])
  .directive('uiCheckbox', require('./checkbox'))
  .directive('uiDropdown', require('./dropdown'))
  .directive('uiPopup', require('./popup'))
  .directive('uiSticky', require('./sticky'))
  .directive('uiVideo', require('./video'))
  #.directive('ngTransition', require('./transition'))
  #.animation('.slide', [require('./animation')])
