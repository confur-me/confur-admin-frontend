'use strict'

_ = require('lodash')

module.exports = ($scope, $q, Setting) ->
  $scope.settings = Setting.query()

  $scope.add = ->
    $scope.settings.push new Setting

  $scope.save = ->
    promises = _.map $scope.settings, (setting) -> setting.$save()
    $q.all(promises).then ->
      Setting.reloadCache()

  $scope.destroy = (key) ->
    setting = settingByKey(key)
    if setting
      setting.$delete().then ->
        $scope.settings = _.without $scope.settings, setting
        Setting.reloadCache()

  $scope.cancel = (key) ->
    setting = settingByKey(key)
    Setting.get(key).then (value) ->
      setting.value = value
      setting.isChanged = false

  settingByKey = (key) ->
    _.find $scope.settings, (s) ->
      s.key == key

