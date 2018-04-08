directive = (ApiService, $rootScope, $document, UtitService, $timeout, AnalyticService, AnalyticHelperService) ->
  link = ($scope, element, attr) ->
    $scope.loaded = false
    $scope.topCountry = []
    $scope.optionChart = {
      type : "GeoChart"
      data : [
        ['Locale', 'Count'],
#        ['Germany', 200],
      ]
      options : {
        width : 900,
        height : 500,
        chartArea : {left : 10, top : 10, bottom : 0, height : "100%"},
        colorAxis : {colors : [
          '#3fb4f9',
          '#ffe424',
          '#ff8812',
          '#e61518',
        ]},
        backgroundColor : '#fff',
        datalessRegionColor : '#d8d8d8',
        defaultColor: '#f5f5f5',
        displayMode : 'regions',
#        region:'VN'
#        displayMode: 'regions',
#        resolution: 'provinces',
        magnifyingGlass:{
          enable: true,
          zoomFactor: 7.5
        }
      }
      formatters : {
        number : [{
          columnNum : 1,
          pattern : "#,##0"
        }]
      }
    }

    $scope.$watch 'optionChart',(data)->
      return unless data
      $scope.optionChart = data
      $scope.loaded = true

    $scope.$watch 'topCountry',(data)->
      return unless data
      $scope.topCountry = data


    return
  directive =
    restrict : 'E'
    scope   :
      optionChart : '=ngOptionChart'
      title : '=ngTitle'
      topCountry:'=ngTopCountry'
      navTabType : '=ngNavTabType'
      navTabRight : '=ngNavTabRight'
    templateUrl : '/template/analytic/directive/module-chart-country/view.html'
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
