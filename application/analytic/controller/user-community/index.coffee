_config = ($stateProvider) ->
  $stateProvider.state "analytic.user-community",
    url : "/user-community"
    templateUrl  : '/template/analytic/controller/user-community/view.html'
    controller: 'analytic.controller.user-community.Ctrl'
_config.$inject = [ "$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService, UtitService, $state, $timeout, $location, $interval) ->
  return
_controller.$inject = ['$rootScope', '$scope', '$http', 'ApiService',
  'UtitService',
  '$state',
  '$timeout',
  '$location',
  '$interval'
]
window.app
.config _config
.run _run
.controller 'analytic.controller.user-community.Ctrl', _controller
