'use strict'

module.exports = ($scope, Conference) ->
  $scope.conferences = Conference.all()
