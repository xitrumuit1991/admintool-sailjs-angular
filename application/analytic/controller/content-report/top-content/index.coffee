_config = ($stateProvider) ->
  $stateProvider.state "analytic.content-report.top-content",
    url : "/top-content"
    templateUrl : '/template/analytic/controller/content-report/top-content/view.html'
    controller : 'analytic.controller.content-report.top-content.Ctrl'
_config.$inject = ["$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService, UtitService, $state, $timeout, $location, $interval, AnalyticService) ->
  $scope.param =
    startDate : ''
    endDate : ''

  $scope.form = [
    title : 'Video'
    type  : 'text'
    key : 'video'
  ,
    title : 'Play'
    key : 'play'
    type  : 'number'
  ,
    title : 'Minutes Viewed'
    key : 'minutes_viewed'
    type  : 'time'
  ,
    title : 'Avg. View Time'
    key : 'avg_view_time'
    type  : 'time'
  ,
    title : 'Player Impressions'
    key : 'player_impressions'
    type  : 'number'
  ,
    title : 'Play to Impression Ratio'
    type  : 'percent'
    key : 'play_to_impression_ratio'
  ,
    title : 'Avg. View Drop-off'
    type  : 'percent'
    key : 'avg_view_drop_off'
  ]

  $scope.data = []

  $scope.pagination =
    totalItems : 100
    currentPage:1
    limit: 10
    onPageChange:()->
      $scope.loadData()


  $scope.$watch 'param.startDate', (data)->
    return if !$scope.param.startDate or !$scope.param.endDate
    console.log '$scope.param.startDate', $scope.param.startDate
    $scope.loadData()

  $scope.$watch 'param.endDate', (data)->
    return if !$scope.param.startDate or !$scope.param.endDate
    console.log '$scope.param.endDate', $scope.param.endDate
    $scope.loadData()

  $scope.topContenModal =
    id : 'topContenModal'
    show : ()->
      $("##{@.id}").modal('show')
    hide : ()->
      $("##{@.id}").modal('hide')

  $scope.loadData = ()->
    $scope.data = []
    _.map [1..10],(index)->
      $scope.data.push({
        video : 'Name video'
        play : _.random(0,20)
        minutes_viewed: _.random(0,1769)
        avg_view_time: _.random(0,361)
        player_impressions: _.random(0,100)
        play_to_impression_ratio: _.random(0,3161)
        avg_view_drop_off: _.random(0,36)
      })
    console.log '$scope.data',$scope.data
    params=
      partner_code: "thvli"
      start : moment($scope.param.startDate,'YYYY-MM-DD').unix()
      end : moment($scope.param.endDate,'YYYY-MM-DD').unix()
    AnalyticService.contentReport.topContentTable params, (err, result)->
      return if err or !result
      console.log 'contentReport.topContentTable; result=', result

  return
_controller.$inject = ['$rootScope', '$scope', '$http', 'ApiService',
  'UtitService',
  '$state',
  '$timeout',
  '$location',
  '$interval', 'AnalyticService'
]

window.app
  .config _config
  .run _run
  .controller 'analytic.controller.content-report.top-content.Ctrl', _controller
