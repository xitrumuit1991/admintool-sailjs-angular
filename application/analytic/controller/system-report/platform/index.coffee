_config = ($stateProvider) ->
  $stateProvider.state "analytic.system-report.platform",
    url : "/platform"
    templateUrl : '/template/analytic/controller/system-report/platform/view.html'
    controller : 'analytic.controller.system-report.platform.Ctrl'
_config.$inject = ["$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService, UtitService, $state, $timeout, $location,
  $interval, AnalyticService, $filter) ->

  $scope.param =
    startDate : ''
    endDate : ''

  $scope.data = []
  $scope.allData = []
  $scope.form = [
    title : 'Platform'
    key : 'platform'
    type : 'text'
  ,
    title : 'Total Duration'
    key : 'total_duration'
    type : 'time'
  ,
    title : 'Total Views'
    key : 'total_views'
    type : 'number'
  ,
    title : 'Avg Views Time'
    key : 'avg_views_time'
    type : 'time'
  ,
    title : 'Player Impression'
    key : 'player_impression'
    type : 'number'
  ,
    title : 'Player Impression Ratio'
    key : 'player_impression_ratio'
    type : 'percent'
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
  loadDataSetDuration = (type='duration')->
    objColor = {
#      label : "Duration",
      fill : false,
      lineTension : 0,
#      backgroundColor : "#9db1ee",
#      borderColor : "#097cff",
      borderCapStyle : 'butt',
      borderDash : [],
      borderDashOffset : 0.0,
      borderJoinStyle : 'miter',
      pointBorderColor : "white",
      pointBackgroundColor : "black",
      pointBorderWidth : 2,
      pointHoverRadius : 4,
      pointHoverBackgroundColor : "brown",
      pointHoverBorderColor : "yellow",
      pointHoverBorderWidth : 2,
      pointRadius : 3,
      pointHitRadius : 6,
#      data : []
      spanGaps : false
    }
    if type is 'duration'
      data = [
        label : "IOS Duration",
        data : []
        backgroundColor : "#097cff",
        borderColor: "#097cff",
      ,
        label : "Android Duration",
        data : []
        backgroundColor : "#f0ad4e",
        borderColor: "#f0ad4e",
      ,
        label : "TV Duration",
        data : []
        backgroundColor : "#e65252",
        borderColor: "#e65252",
      ,
        label : "Web Duration",
        data : []
        backgroundColor : "#1dff58",
        borderColor : "#1dff58",
      ]
    else if type is 'view'
      data = [
        label : "IOS View",
        data : []
        backgroundColor : "#097cff",
        borderColor: "#097cff",
      ,
        label : "Android View",
        data : []
        backgroundColor : "#f0ad4e",
        borderColor: "#f0ad4e",
      ,
        label : "TV View",
        data : []
        backgroundColor : "#1dff58",
        borderColor : "#1dff58",
      ,
        label : "Web View",
        data : []
        backgroundColor : "#1dff58",
        borderColor : "#1dff58",
      ]
    _.map data,(item)->
      item = _.extend(item, objColor)
    return data

  $scope.dataSetChart = []
  $scope.allDataChart = []
  $scope.chartNavTabType = [
    title : 'Duration'
    action : ()->
      $scope.parseDataChart('duration')
  ,
    title : 'Views'
    action : ()->
      $scope.parseDataChart('view')
  ]

  $scope.$watch 'param.startDate', (data)->
    return if !$scope.param.startDate or !$scope.param.endDate
    console.log '$scope.param.startDate', $scope.param.startDate
    $scope.loadData()

  $scope.$watch 'param.endDate', (data)->
    return if !$scope.param.startDate or !$scope.param.endDate
    console.log '$scope.param.endDate', $scope.param.endDate
    $scope.loadData()

  $scope.parseDataTable = ()->
    $scope.data = []
    start = ($scope.pagination.currentPage - 1) * $scope.pagination.limit
    end = start + $scope.pagination.limit
    while start <= end && start <= $scope.pagination.totalItems
      $scope.data.push($scope.allData[start]) if $scope.allData[start]
      start++
#    console.log '$scope.data',$scope.data

  $scope.parseDataChart = (type = 'duration')->
    $scope.dataLabelsChart = []
    $scope.dataSetChart = loadDataSetDuration(type)
    $scope.dataSetChart[0].data = []
    $scope.dataSetChart[1].data = []
    $scope.dataSetChart[2].data = []
    $scope.dataSetChart[3].data = []
    _.map $scope.allDataChart, (item)->
      $scope.dataLabelsChart.push(moment(item.unix_timestamp_as_string).format('DD/MM/YYYY'))
      if type is 'duration'
        $scope.dataSetChart[0].data.push(item['total_ios_duration'])
        $scope.dataSetChart[1].data.push(item['total_android_duration'])
        $scope.dataSetChart[2].data.push(item['total_tv_duration'])
        $scope.dataSetChart[3].data.push(item['total_web_duration'])
      if type is 'view'
        $scope.dataSetChart[0].data.push(item['total_ios_views'])
        $scope.dataSetChart[1].data.push(item['total_android_views'])
        $scope.dataSetChart[2].data.push(item['total_tv_views'])
        $scope.dataSetChart[3].data.push(item['total_web_views'])

  $scope.loadData = ()->
    params =
      partner_code : "thvli"
      start : moment($scope.param.startDate, 'YYYY-MM-DD').unix()
      end : moment($scope.param.endDate, 'YYYY-MM-DD').unix()
    AnalyticService.systemReport.platformTable params, (err, result)->
      return if err or !result
      $scope.allData = result.data
      $scope.pagination.totalItems = result.num_returned_items
      $scope.parseDataTable() if _.isFunction($scope.parseDataTable)

    AnalyticService.systemReport.platformChart params, (err, result)->
      return if err or !result
      $scope.allDataChart = result.data
      $scope.parseDataChart("duration") if _.isFunction($scope.parseDataChart)

    AnalyticService.systemReport.platformSummary params, (err, result)->
      return if err or !result
      $scope.dataSummary = result.data

  return
_controller.$inject = ['$rootScope', '$scope', '$http', 'ApiService',
  'UtitService',
  '$state',
  '$timeout',
  '$location',
  '$interval','AnalyticService','$filter'
]
window.app
  .config _config
  .run _run
  .controller 'analytic.controller.system-report.platform.Ctrl', _controller
