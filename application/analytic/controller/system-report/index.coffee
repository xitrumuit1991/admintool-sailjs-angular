_config = ($stateProvider) ->
  $stateProvider.state "analytic.system-report",
    url : "/system-report"
    templateUrl : '/template/analytic/controller/system-report/view.html'
    controller : 'analytic.controller.system-report.Ctrl'
_config.$inject = ["$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService, UtitService, $state, $timeout, $location, $interval) ->
  $scope.blockSytemReport = [
    title : 'OS Report'
    href : 'analytic.system-report.os'
    icon : 'fa fa-pie-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ,
    title : 'Browser Report'
    href : 'analytic.system-report.browser'
    icon : 'fa fa-area-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ,
    title : 'Platform Report'
    href : 'analytic.system-report.platform'
    icon : 'fa fa-line-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ]

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
  .controller 'analytic.controller.system-report.Ctrl', _controller
