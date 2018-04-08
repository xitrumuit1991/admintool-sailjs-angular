_config = ($stateProvider) ->
  $stateProvider.state "analytic.user-community.geographic",
    url : "/geographic"
    templateUrl  : '/template/analytic/controller/user-community/geographic/view.html'
    controller: 'analytic.controller.user-community.geographic.Ctrl'
_config.$inject = [ "$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService, UtitService, $state, $timeout, $location, $interval,
  AnalyticService,$filter) ->
  $rootScope.metaPageTitle = 'Geographic Report'
  $scope.param =
    startDate : ''
    endDate : ''

  $scope.data = []
  $scope.allData = []
  $scope.form = [
    title : 'Country Name'
    key : 'country_name'
    type : 'text'
  ,
    title : 'total content views'
    key : 'total_content_views'
    type : 'number'
  ,
    title : 'total android views'
    key : 'total_android_views'
    type : 'number'
  ,
    title : 'total ios views'
    key : 'total_ios_views'
    type : 'number'
  ,
    title : 'total tv views'
    key : 'total_tv_views'
    type : 'number'
  ,
    title : 'total web views'
    key : 'total_web_views'
    type : 'number'
  ,
    title : 'Total Duration'
    key : 'total_duration'
    type : 'time'
  ,
    title : 'Total Android Duration'
    key : 'total_android_duration'
    type : 'time'
  ,
    title : 'Total IOS Duration'
    key : 'total_ios_duration'
    type : 'time'
  ,
    title : 'Total TV Duration'
    key : 'total_tv_duration'
    type : 'time'
  ,
    title : 'Total Web Duration'
    key : 'total_web_duration'
    type : 'time'
  ]
  $scope.pagination = {
    totalItems : 0
    currentPage : 1
    limit : 10
    onPageChange : ()->
      $scope.parseDataTable()
  }

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
    type : "GeoChart"
    data : [
      ['Locale', 'Count'],
#        ['Germany', 200],
    ]
    options : {
      width : 1000,
      height : 500,
      chartArea : {left : 10, top : 10, bottom : 0, height : "100%"},
      colorAxis : {colors : ['#e65252', '#90be2e', '#097cff']},
      backgroundColor : '#fff',
      datalessRegionColor : '#b2b2b2',
      displayMode : 'regions'
    }
    formatters : {
      number : [{
        columnNum : 1,
        pattern : "#,##0"
      }]
    }
  }
  $scope.topCountry = []
  $scope.keyCountryCity = 'country_name'
  $scope.keyDurationOrView = 'total_duration'

  geoChartByDurationOrViews = (durationOrView = 'total_duration', countryOrCity = 'country_name')->
    params =
      partner_code :  $rootScope.user.partner_code || "thvli"
      start : moment($scope.param.startDate, 'YYYY-MM-DD').unix()
      end : moment($scope.param.endDate, 'YYYY-MM-DD').unix()
      type_name: countryOrCity
      top_n: 50
      order_by_field: durationOrView
    $.blockUI()
    AnalyticService.userCommunityReport.geoChart params, (err, result)->
      $.unblockUI()
      return if err or !result
      $scope.optionChart.data = [ ['Locale', 'Count']]
      _.map result.data, (item)->
        $scope.optionChart.data.push([item[countryOrCity], item[durationOrView]])
      $scope.topCountry = _.orderBy(result.data, [durationOrView],['desc'])

  $scope.chartNavTabType = [
    title : 'Duration'
    action : ()->
      $scope.keyDurationOrView = 'total_duration'
      geoChartByDurationOrViews($scope.keyDurationOrView, $scope.keyCountryCity)
  ,
    title : 'Views'
    action : ()->
      $scope.keyDurationOrView = 'total_views'
      geoChartByDurationOrViews($scope.keyDurationOrView, $scope.keyCountryCity)
  ]

  $scope.chartNavTabRight = [
    title : 'Country'
    action : ()->
      $scope.keyCountryCity = 'country_name'
      geoChartByDurationOrViews($scope.keyDurationOrView,$scope.keyCountryCity)
  ,
    title : 'City'
    action : ()->
      $scope.keyCountryCity = 'city_name'
      geoChartByDurationOrViews($scope.keyDurationOrView,$scope.keyCountryCity)
  ]

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
    if !data
      return UtitService.notifyError('Can not gen Excel file!')
    ws = XLSX.utils.json_to_sheet(data) #/* generate a worksheet */
    wb = XLSX.utils.book_new() #/* add to workbook */
    XLSX.utils.book_append_sheet(wb, ws, "geo_report")
    #write workbook and force a download
    XLSX.writeFile(wb, "#{moment().format('DD/MM/YYYY')}_browser_report.xlsx")

  $scope.parseDataTable = ()->
    $scope.data = []
    start = ($scope.pagination.currentPage - 1) * $scope.pagination.limit
    end = start + $scope.pagination.limit
    while start < end && start <= $scope.pagination.totalItems
      $scope.data.push($scope.allData[start]) if $scope.allData[start]
      start++


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
      partner_code :  $rootScope.user.partner_code || "thvli"
      start : moment($scope.param.startDate, 'YYYY-MM-DD').unix()
      end : moment($scope.param.endDate, 'YYYY-MM-DD').unix()
      type_name: "country_name"
    $.blockUI()
    AnalyticService.userCommunityReport.geoTable params, (err, result)->
      $.unblockUI()
      return if err or !result
      $scope.allData = result.data
      $scope.pagination.totalItems = result.num_returned_items
      $scope.parseDataTable() if _.isFunction($scope.parseDataTable)

    geoChartByDurationOrViews()

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
  .controller 'analytic.controller.user-community.geographic.Ctrl', _controller
