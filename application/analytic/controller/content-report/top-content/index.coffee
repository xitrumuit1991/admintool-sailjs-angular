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

  $scope.data = []
  $scope.allData = []

  $scope.form = [
    title : 'content id'
    key : 'content_id'
    type  : 'text'
  ,
    title : 'total Duration'
    key : 'total_duration'
    type  : 'time'
  ,
    title : 'total ios duration'
    key : 'total_ios_duration'
    type  : 'time'
  ,
    title : 'total android duration'
    key : 'total_android_duration'
    type  : 'time'
  ,
    title : 'total tv duration'
    key : 'total_tv_duration'
    type  : 'time'
  ,
    title : 'total web duration'
    key : 'total_web_duration'
    type  : 'time'
  ,
    title : 'total content views'
    key : 'total_content_views'
    type  : 'number'
  ,
    title : 'total android views'
    key : 'total_android_views'
    type  : 'number'
  ,
    title : 'total ios views'
    key : 'total_ios_views'
    type  : 'number'
  ,
    title : 'total tv views'
    key : 'total tv views'
    type  : 'number'
  ,
    title : 'total web views'
    key : 'total_web_views'
    type  : 'number'
  ]

  $scope.pagination =
    totalItems : 0
    currentPage:1
    limit: 10
    onPageChange:()->
      $scope.parseData()


  $scope.formSummary = [
    title : 'Total Views'
    key : 'total_views'
    type  : 'number'
  ,
    title : 'Total Duration'
    key : 'total_duration'
    type  : 'time'
  ,
    title : 'Avg. View Time'
    key : 'avg_view_time'
    type  : 'time'
  ,
    title : 'Player Impressions'
    type  : 'number'
    key : 'player_impressions'
  ,
    title : 'Play to Impression Ratio'
    type  : 'percent'
    key : 'play_to_impression_ratio'
  ,
    title : 'Avg. View Drop-off'
    type  : 'percent'
    key : 'avg_view_drop_off'
  ]

  $scope.dataSummary = {}

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

  $scope.parseData = ()->
    $scope.data = []
    start = ($scope.pagination.currentPage-1)*$scope.pagination.limit
    end =   start + $scope.pagination.limit
    while start <= end && start <= $scope.pagination.totalItems && end <= $scope.pagination.totalItems
      $scope.data.push($scope.allData[start])
      start++

  $scope.loadData = ()->
    params=
      partner_code: "thvli"
      start : moment($scope.param.startDate,'YYYY-MM-DD').unix()
      end : moment($scope.param.endDate,'YYYY-MM-DD').unix()
    AnalyticService.contentReport.topContentTable params, (err, result)->
      return if err or !result
      $scope.allData = result.data
      $scope.pagination.totalItems = result.num_returned_items
      $scope.parseData()
    AnalyticService.contentReport.topContentChart params, (err, result)->
      console.log 'topContentChart', result
      return if err or !result
    AnalyticService.contentReport.topContentSummary params, (err, result)->
      console.log 'topContentSummary', result
      return if err or !result
      $scope.dataSummary = result.data

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
