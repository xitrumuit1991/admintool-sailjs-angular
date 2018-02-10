"use strict"
filter = ($rootScope, UtitService)->
  return (bytes)->
    return UtitService.formatBytes(bytes)

filter.$inject = ['$rootScope', 'UtitService']
angular.module('sbd-admin').filter('formatBytes',filter)