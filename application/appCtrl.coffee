_config = ($stateProvider) ->
_config.$inject = [  "$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $stateParams, $scope, ApiService, UtitService,$state, $timeout)->
  console.warn 'init AppCtrl Success'
#  console.warn '$rootScope.topSidebar',$rootScope.topSidebar
#  console.warn '$rootScope.user',$rootScope.user
  return
_controller.$inject = ['$rootScope', '$stateParams', '$scope', 'ApiService', 'UtitService',  '$state', '$timeout']

angular.module("sbd-admin")
.config _config
.run _run
.controller 'AppCtrl', _controller

