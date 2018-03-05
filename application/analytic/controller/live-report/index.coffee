_config = ($stateProvider) ->
  $stateProvider.state "analytic.live-report",
    url : "/live-report"
    templateUrl : '/template/analytic/controller/live-report/view.html'
    controller : 'analytic.controller.live-report.Ctrl'
_config.$inject = ["$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService, UtitService, $state, $timeout, $location, $interval) ->
  $scope.param =
    startDate : ''
    endDate : ''

  $scope.$watch 'param.startDate',(data)->
    return unless data
    console.log '$scope.param.startDate',$scope.param.startDate

  $scope.$watch 'param.endDate',(data)->
    return unless data
    console.log '$scope.param.endDate',$scope.param.endDate

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
  .controller 'analytic.controller.live-report.Ctrl', _controller
