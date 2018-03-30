directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, AnalyticHelperService,$state) ->
  link = ($scope, element, attr) ->
#    $scope.optionChart = {
#      type: 'line',
#      data: {
#        labels: []
#        datasets: [{
#          label: "User View",
#          fill: false,
#          lineTension: 0,
#          backgroundColor: "#9db1ee",
#          borderColor: "#097cff",
#          borderCapStyle: 'butt',
#          borderDash: [],
#          borderDashOffset: 0.0,
#          borderJoinStyle: 'miter',
#          pointBorderColor: "white",
#          pointBackgroundColor: "black",
#          pointBorderWidth: 1,
#          pointHoverRadius: 8,
#          pointHoverBackgroundColor: "brown",
#          pointHoverBorderColor: "yellow",
#          pointHoverBorderWidth: 2,
#          pointRadius: 4,
#          pointHitRadius: 10,
#          data: []
#          spanGaps: false
#        }]
#      },
#      options: {
#        maintainAspectRatio: false,
#        spanGaps: false,
#        tooltips: {
#          callbacks: {
#            label: (tooltipItem, data) ->
#              label = data.datasets[tooltipItem.datasetIndex].label;
#              value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
#              switch $scope.param.type
#                when 'play_through'
#                  return "#{label} : #{value}%"
#                  break
#                when 'play_request'
#                  return "#{label} : #{value}"
#                  break
#                when 'unique_user'
#                  break
#              return label + ': ' + value
#            footer: (tooltipItems, data)->
#              return ['new line', 'another line']
#          }
#        }
#        scales: {
#          yAxes: [{
#            scaleLabel: {
#              display: true,
#            }
#            ticks: {
#              beginAtZero:false
#              callback: (value, index, values)->
#                switch $scope.param.type
#                  when 'play_request'
#                    $scope.optionChart.data.datasets[0].label = 'Play request'
#                    break
#                  when 'play_through'
#                    $scope.optionChart.data.datasets[0].label = 'Playthrough'
#                    break
#                  else
#                    $scope.optionChart.data.datasets[0].label = 'Unique User'
#                    break
#                if $scope.param.type is 'play_through'
#                  return value+"%"
#                return value
#            }
#          }]
#        }
#      }
#    }

    topContentChart = null

    $scope.$watch 'dataSetChart',(data)->
      return unless data
      $scope.optionChart.data.datasets = data
      topContentChart.update() if topContentChart

    $scope.$watch 'labelChart',(data)->
      return unless data
      $scope.optionChart.data.labels = data
      topContentChart.update() if topContentChart

    $scope.$watch 'optionChart',(data)->
      return unless data
      if !topContentChart
        topContentChart = new Chart(document.getElementById("moduleChart"), $scope.optionChart)

    return
  directive =
    restrict: 'E'
    scope   :
      optionChart : '=ngOptionChart'
      title : '=ngTitle'
      navTabType : '=ngNavTabType'
      labelChart : '=ngLabelChart'
      dataSetChart : '=ngDatasetChart'
    templateUrl: '/template/analytic/directive/module-chart/view.html'
    link    : link
  return directive
directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticHelperService','$state']
angular
  .module 'sbd-admin'
  .directive "uizaModuleChart", directive
