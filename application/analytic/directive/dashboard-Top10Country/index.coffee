directive = (ApiService, $rootScope, $document, UtitService, $timeout, AnalyticService, AnalyticHelperService) ->
  link = ($scope, element, attr) ->
    $scope.dataTooltip = 'Top 10 most viewed countries'
    $scope.top10Country = []
    $scope.loaded = false
    $scope.chart =
      type : "GeoChart"
      data : [
        ['Locale', 'Count'],
#        ['Germany', 200],
#        ['United States', 300],
#        ['Brazil', 400],
#        ['Canada', 500],
#        ['France', 600],
#        ['RU', 700]
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

    $scope.param =
      start_date : AnalyticHelperService.startDate()
      end_date : AnalyticHelperService.endDate()

    randomData = ()->
      $scope.top10Country = []
      $scope.loaded = true
      _.map [1..10], (index)->
        demoOb =
          name : AnalyticHelperService.randomCountryName()
          value : _.random(0, 1000)
        $scope.top10Country.push(demoOb)
        $scope.chart.data.push( [demoOb.name, demoOb.value] )

    #call
    randomData()

    #    AnalyticService.analytic.top10Country((err, result)->
    #      return if err
    #      $scope.top10Country = result.data if result
    #      i = 0
    #      while result and result.data and i < result.data.length
    #        arr = [result.data[i].name, result.data[i].value]
    #        chart1.data.push(arr)
    #        i++
    #      $scope.chart = chart1
    #      $scope.loaded = true
    #    , $scope.param)

    return
  directive =
    restrict : 'E'
    scope : {}
    templateUrl : '/template/analytic/directive/dashboard-Top10Country/view.html'
    link : link

  return directive
directive.$inject = [
  'ApiService',
  '$rootScope',
  '$document',
  'UtitService',
  '$timeout'
  'AnalyticService',
  'AnalyticHelperService'
]
angular.module 'sbd-admin'
  .directive "sbdDashboardTopTenCountry", directive
