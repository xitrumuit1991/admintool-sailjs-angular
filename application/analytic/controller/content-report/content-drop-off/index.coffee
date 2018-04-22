_config = ($stateProvider) ->
  $stateProvider.state "analytic.content-report.content-drop-off",
    url : "/content-drop-off"
    templateUrl  : '/template/analytic/controller/content-report/content-drop-off/view.html'
    controller: 'analytic.controller.content-report.content-drop-off.Ctrl'
_config.$inject = [ "$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService,
  UtitService, $state, $timeout, $location,
  $interval, AnalyticService, $filter, AnalyticHelperService) ->

  $rootScope.metaPageTitle = 'Drop Off'
  $scope.param =
    startDate : ''
    endDate : ''

  $scope.data = []
  $scope.allData = []

  "25-play-through": 286,
  "50-play-through": 329,
  "75-play-through": 2010,
  "100-play-through": 230,
  "play-through_ratio": 6.3

  $scope.form = [
    title : 'Title'
    key : 'title'
    type : 'text'
  ,
    title : 'total_play'
    key : 'total_play'
    type : 'number'
  ,
    title : '25 play through'
    key : '25-play-through'
    type : 'number'
  ,
    title : '50 play through'
    key : '50-play-through'
    type : 'number'
  ,
    title : '75 play through'
    key : '75-play-through'
    type : 'number'
  ,
    title : '100 play through'
    key : '100-play-through'
    type : 'number'
  ,
    title : 'play through ratio'
    key : 'play-through_ratio'
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
    title : 'Total Play'
    key : 'total_play'
    type : 'number'
  ,
    title : '25 play through'
    key : '25-play-through'
    type : 'number'
  ,
    title : '50 play through'
    key : '50-play-through'
    type : 'number'
  ,
    title : '75 play through'
    key : '75-play-through'
    type : 'number'
  ,
    title : '100 play through'
    key : '100-play-through'
    type : 'number'
  ,
    title : 'play through ratio'
    key : 'play-through_ratio'
    type : 'percent'
  ]
  $scope.dataSummary = {}

  #
  #
  #
  #
  $scope.optionChart = {
    type: 'bar',
    data: {
      labels: [],
      datasets: [
        {
          label : "Value",
          fill : false,
          lineTension : 0,
#          backgroundColor : "#9db1ee",
          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
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
          data: [],
          spanGaps : false
        }
      ]
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
  dropOffChart = new Chart(document.getElementById("dropOffChart"),$scope.optionChart );

  $scope.$watch 'param.startDate', (data)->
    return if !$scope.param.startDate or !$scope.param.endDate
    console.log '$scope.param.startDate', $scope.param.startDate
    $scope.loadData()

  $scope.$watch 'param.endDate', (data)->
    return if !$scope.param.startDate or !$scope.param.endDate
    console.log '$scope.param.endDate', $scope.param.endDate
    $scope.loadData()

  $scope.actionDownload = ()->
    data = null
    try
      data = JSON.parse(angular.toJson( $scope.allData )) #collect data
    catch e
      console.warn e
    if !data then  return UtitService.notifyError('Can not gen Excel file!')
    paramListId =
      partner_code: $rootScope.user.partner_code || "thvli"
      content_ids: _.map(data,'content_id')
    AnalyticService.contentReport.getContentByIds paramListId, (err, result)->
      return UtitService.notifyError('Can not gen Excel file!') if err or !result
      _.mapKeys result.data, (value, key)->
        indexFind = _.findIndex(data,{'content_id' : key})
        if indexFind != -1
          data[indexFind].title = value.title
          data[indexFind].slug = value.slug
      _.map data,(item)->
        delete item.source_id
        delete item.status
        delete item.id
        item = AnalyticHelperService.sortKeyOfObject(item)
      ws = XLSX.utils.json_to_sheet(data) #/* generate a worksheet */
      wb = XLSX.utils.book_new() #/* add to workbook */
      XLSX.utils.book_append_sheet(wb, ws, "drop_off")
      #write workbook and force a download
      XLSX.writeFile(wb, "#{moment().format('DD/MM/YYYY')}_drop_off.xlsx")

  $scope.parseDataTable = ()->
    $scope.data = []
    start = ($scope.pagination.currentPage - 1) * $scope.pagination.limit
    end = start + $scope.pagination.limit
    while start < end && start <= $scope.pagination.totalItems
      $scope.data.push($scope.allData[start]) if $scope.allData[start]
      start++
    paramListId =
      partner_code: $rootScope.user.partner_code || "thvli"
      content_ids: _.map($scope.data,'content_id')
    AnalyticService.contentReport.getContentByIds paramListId, (err, result)->
      return if err or !result
      _.mapKeys result.data, (value, key)->
        indexFind = _.findIndex($scope.data,{'content_id' : key})
        if indexFind != -1
          $scope.data[indexFind] = _.extend($scope.data[indexFind], value)

  $scope.parseDataChart = (dataApi)->
    $scope.optionChart.data.labels = []
    $scope.optionChart.data.datasets[0].data = []
    keyAllow = [
      "total_play"
      "25-play-through"
      "50-play-through"
      "75-play-through"
      "100-play-through"
#      "play-through_ratio"
    ]
    _.map dataApi,(value, key)->
      if key in keyAllow
        if key is 'play-through_ratio'
          $scope.optionChart.data.labels.push('play through ratio %')
        else
          $scope.optionChart.data.labels.push(key)
        $scope.optionChart.data.datasets[0].data.push(value)
    dropOffChart.update()

  $scope.sortByKey = (sortkey, columnItem )->
    _.map $scope.form,(item)->
      if item.key != sortkey then delete item.sortType = null
    return if !sortkey or !columnItem
    if !columnItem.sortType or columnItem.sortType == 'desc'
      columnItem.sortType = 'asc'
    else if columnItem.sortType == 'asc'
      columnItem.sortType = 'desc'
    $scope.allData = _.orderBy($scope.allData, ["#{sortkey}"],["#{columnItem.sortType}"])
    $scope.pagination.currentPage = 1
    $scope.parseDataTable()

  $scope.loadData = ()->
    params =
      partner_code : $rootScope.user.partner_code || "thvli"
      start : moment($scope.param.startDate, 'YYYY-MM-DD').unix()
      end : moment($scope.param.endDate, 'YYYY-MM-DD').unix()
    $.blockUI()
    AnalyticService.contentReport.dropOffTable params, (err, result)->
      $.unblockUI()
      return if err or !result
      $scope.allData = result.data
      $scope.pagination.totalItems = result.num_returned_items
      $scope.parseDataTable()
    AnalyticService.contentReport.dropOffSummary params, (err, result)->
      return if err or !result
      $scope.dataSummary = result.data
      $scope.parseDataChart(result.data)


  return
_controller.$inject = ['$rootScope', '$scope', '$http', 'ApiService',
  'UtitService', '$state', '$timeout', '$location',
  '$interval', 'AnalyticService', '$filter','AnalyticHelperService'
]
window.app
  .config _config
  .run _run
  .controller 'analytic.controller.content-report.content-drop-off.Ctrl', _controller
