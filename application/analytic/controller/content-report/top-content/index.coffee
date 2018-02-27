_config = ($stateProvider) ->
  $stateProvider.state "analytic.content-report.top-content",
    url : "/top-content"
    templateUrl  : '/template/analytic/controller/content-report/top-content/view.html'
    controller: 'analytic.controller.content-report.top-content.Ctrl'
_config.$inject = [ "$stateProvider"]

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

  $scope.topContenModal=
    id : 'topContenModal'
    show : ()->
      $("##{@.id}").modal('show')
    hide : ()->
      $("##{@.id}").modal('hide')


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
  .controller 'analytic.controller.content-report.top-content.Ctrl', _controller
