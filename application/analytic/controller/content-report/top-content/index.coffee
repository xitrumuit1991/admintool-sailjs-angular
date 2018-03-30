_config = ($stateProvider) ->
  $stateProvider.state "analytic.content-report.top-content",
    url : "/top-content"
    templateUrl : '/template/analytic/controller/content-report/top-content/view.html'
    controller : 'analytic.controller.content-report.top-content.Ctrl'
_config.$inject = ["$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService,
  UtitService, $state, $timeout, $location,
  $interval, AnalyticService, $filter) ->
  $scope.param =
    startDate : ''
    endDate : ''

  $scope.data = []
  $scope.allData = []
  $scope.form = [
    title : 'Content Id'
    key : 'content_id'
    type : 'text'
  ,
    title : 'Total Duration'
    key : 'total_duration'
    type : 'time'
  ,
    title : 'Total IOS Duration'
    key : 'total_ios_duration'
    type : 'time'
  ,
    title : 'Total Android Duration'
    key : 'total_android_duration'
    type : 'time'
  ,
    title : 'Total TV Duration'
    key : 'total_tv_duration'
    type : 'time'
  ,
    title : 'Total Web duration'
    key : 'total_web_duration'
    type : 'time'
  ,
    title : 'Total Content Views'
    key : 'total_content_views'
    type : 'number'
  ,
    title : 'Total Android Views'
    key : 'total_android_views'
    type : 'number'
  ,
    title : 'Total IOS Views'
    key : 'total_ios_views'
    type : 'number'
  ,
    title : 'Total Tv Views'
    key : 'total_tv_views'
    type : 'number'
  ,
    title : 'Total Web Views'
    key : 'total_web_views'
    type : 'number'
  ]

  $scope.pagination =
    totalItems : 0
    currentPage : 1
    limit : 10
    onPageChange : ()->
      $scope.parseDataTable()

  #
  #
  #
  #
  $scope.formSummary = [
    title : 'Total Views'
    key : 'total_views'
    type : 'number'
  ,
    title : 'Total Duration'
    key : 'total_duration'
    type : 'time'
  ,
    title : 'Avg. View Time'
    key : 'avg_view_time'
    type : 'time'
  ,
    title : 'Player Impressions'
    type : 'number'
    key : 'player_impressions'
  ,
    title : 'Play to Impression Ratio'
    type : 'percent'
    key : 'play_to_impression_ratio'
  ,
    title : 'Avg. View Drop-off'
    type : 'percent'
    key : 'avg_view_drop_off'
  ]
  $scope.dataSummary = {}

  #
  #
  #
  #
  $scope.optionChart = {
    type : 'line',
    data : {
      labels : []
      datasets : []
    },
    options : {
      maintainAspectRatio : false,
      spanGaps : false,
      legend:
        display: true,
        labels:
          fontColor: "#000",
      tooltips : {
        callbacks : {
          label : (tooltipItem, data) ->
            label = data.datasets[tooltipItem.datasetIndex].label
            value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
            return label + ' : '+ $filter('number')(value, 0)
        }
      }
      scales: {
        yAxes : [{
          scaleLabel: {
            display: true,
          }
          ticks : {
            beginAtZero:true
          }
        }]
      }
    }
  }
  $scope.dataLabelsChart = []
  $scope.dataSetChart = [{
    label : "Duration",
    fill : false,
    lineTension : 0,
    backgroundColor : "#9db1ee",
    borderColor : "#097cff",
    borderCapStyle : 'butt',
    borderDash : [],
    borderDashOffset : 0.0,
    borderJoinStyle : 'miter',
    pointBorderColor : "white",
    pointBackgroundColor : "black",
    pointBorderWidth : 1,
    pointHoverRadius : 8,
    pointHoverBackgroundColor : "brown",
    pointHoverBorderColor : "yellow",
    pointHoverBorderWidth : 2,
    pointRadius : 4,
    pointHitRadius : 10,
    data : []
    spanGaps : false
  }]
  $scope.allDataChart = []
  $scope.chartNavTabType = [
    title : 'Duration'
    action : ()->
      console.log 'click action Duration'
      $scope.parseDataChart('Duration', 'total_duration')
  ,
    title : 'Views'
    action : ()->
      console.log 'click action Views'
      $scope.parseDataChart('Views', 'total_content_views')
  ]

  $scope.$watch 'param.startDate', (data)->
    return if !$scope.param.startDate or !$scope.param.endDate
    console.log '$scope.param.startDate', $scope.param.startDate
    $scope.loadData()

  $scope.$watch 'param.endDate', (data)->
    return if !$scope.param.startDate or !$scope.param.endDate
    console.log '$scope.param.endDate', $scope.param.endDate
    $scope.loadData()

  #  $scope.topContenModal =
  #    id : 'topContenModal'
  #    show : ()->
  #      $("##{@.id}").modal('show')
  #    hide : ()->
  #      $("##{@.id}").modal('hide')

  $scope.parseDataTable = ()->
    $scope.data = []
    start = ($scope.pagination.currentPage - 1) * $scope.pagination.limit
    end = start + $scope.pagination.limit
    while start <= end && start <= $scope.pagination.totalItems && end <= $scope.pagination.totalItems
      $scope.data.push($scope.allData[start])
      start++

  $scope.parseDataChart = (label, key)->
    console.log '$scope.allDataChart', $scope.allDataChart
    $scope.dataLabelsChart = []
    $scope.dataSetChart[0].data = []
    $scope.dataSetChart[0].label = label
    _.map $scope.allDataChart, (item)->
      $scope.dataLabelsChart.push(moment(item.unix_timestamp_as_string).format('DD/MM/YYYY'))
      $scope.dataSetChart[0].data.push(item[key])

  $scope.loadData = ()->
    params =
      partner_code : "thvli"
      start : moment($scope.param.startDate, 'YYYY-MM-DD').unix()
      end : moment($scope.param.endDate, 'YYYY-MM-DD').unix()
    AnalyticService.contentReport.topContentTable params, (err, result)->
      return if err or !result
      $scope.allData = result.data
      $scope.pagination.totalItems = result.num_returned_items
      $scope.parseDataTable()
    AnalyticService.contentReport.topContentChart params, (err, result)->
      console.log 'topContentChart', result
      return if err or !result
      $scope.allDataChart = result.data
      $scope.parseDataChart("Duration", 'total_duration')

    AnalyticService.contentReport.topContentSummary params, (err, result)->
      console.log 'topContentSummary', result
      return if err or !result
      $scope.dataSummary = result.data

  return
_controller.$inject = ['$rootScope', '$scope', '$http', 'ApiService',
  'UtitService', '$state', '$timeout', '$location',
  '$interval', 'AnalyticService', '$filter'
]

window.app
  .config _config
  .run _run
  .controller 'analytic.controller.content-report.top-content.Ctrl', _controller
