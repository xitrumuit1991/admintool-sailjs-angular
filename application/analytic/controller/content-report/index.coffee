_config = ($stateProvider) ->
  $stateProvider.state "analytic.content-report",
    url : "/content-report"
    templateUrl  : '/template/analytic/controller/content-report/view.html'
    controller: 'analytic.controller.content-report.Ctrl'
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
.controller 'analytic.controller.content-report.Ctrl', _controller
