directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, AnalyticHelperService,$state) ->
  link = ($scope, element, attr) ->
    $scope.topContent = []
    $scope.dataTooltip = 'Top Content'

    $scope.param =
      start_date : AnalyticHelperService.startDate()
      end_date : AnalyticHelperService.endDate()
      interval : '1w' #Time interval,         ex: 1w, 1M, 3M, 6M, 1y.
      time_interval : '1w' #Time interval,    ex: 1w, 1M, 3M, 6M, 1y.
      type : 'unique_user' #Type of data to get. ex: play_rq, unique_user, hours_watched, play_through.

    $scope.optionChart = {
      type: 'line',
      data: {
        labels: []
        datasets: [{
          label: "User View",
          fill: false,
          lineTension: 0,
          backgroundColor: "#9db1ee",
          borderColor: "#097cff",
          borderCapStyle: 'butt',
          borderDash: [],
          borderDashOffset: 0.0,
          borderJoinStyle: 'miter',
          pointBorderColor: "white",
          pointBackgroundColor: "black",
          pointBorderWidth: 1,
          pointHoverRadius: 8,
          pointHoverBackgroundColor: "brown",
          pointHoverBorderColor: "yellow",
          pointHoverBorderWidth: 2,
          pointRadius: 4,
          pointHitRadius: 10,
          data: []
          spanGaps: false
        }]
      },
      options: {
        maintainAspectRatio: false,
        spanGaps: false,
        tooltips: {
          callbacks: {
            label: (tooltipItem, data) ->
              label = data.datasets[tooltipItem.datasetIndex].label;
              value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
              switch $scope.param.type
                when 'play_through'
                  return "#{label} : #{value}%"
                  break
                when 'play_request'
                  return "#{label} : #{value}"
                  break
                when 'unique_user'
                  break
              return label + ': ' + value
#            footer: (tooltipItems, data)->
#              return ['new line', 'another line']
          }
        }
        scales: {
          yAxes: [{
            scaleLabel: {
              display: true,
            }
            ticks: {
              beginAtZero:false
              callback: (value, index, values)->
                switch $scope.param.type
                  when 'play_request'
                    $scope.optionChart.data.datasets[0].label = 'Play request'
                    break
                  when 'play_through'
                    $scope.optionChart.data.datasets[0].label = 'Playthrough'
                    break
                  else
                    $scope.optionChart.data.datasets[0].label = 'Unique User'
                    break
                if $scope.param.type is 'play_through'
                  return value+"%"
                return value
            }
          }]
        }
      }
    }
    topContentChart = new Chart(document.getElementById("topContentLineChart"), $scope.optionChart)

    $scope.onChangeTypeView = (type)->
      $scope.param.type = type
      $scope.loadData()

    $scope.onChangeTypeInterval = (type)->
      $scope.param.interval = type
      $scope.param.time_interval = type
      $scope.loadData()


    $scope.loadData = ()->
      $scope.optionChart.data.labels = []
      $scope.optionChart.data.datasets[0].data=[]
      _.map [0..20],(index)->
        time = (new Date()).getTime() + index*10000
        date = new Date(time)
        $scope.optionChart.data.labels.push( moment(date).format("DD/MM/YYYY") )
        $scope.optionChart.data.datasets[0].data.push( _.random(0,100) )
      topContentChart.update()

#      AnalyticService.analytic.topContentLine((err, result)->
#        return if err or !result
#        _.map result.data , (item)->
#          date = new Date(parseInt(item.time))
#          $scope.optionChart.data.labels.push( moment(date).format("DD/MM/YYYY") )
#          $scope.optionChart.data.datasets[0].data.push(item.value)
#        topContentChart.update()
#      , $scope.param)
#
#      AnalyticService.analytic.topContent((err, result)->
#        return if err or !result
#        _.map result.data, (item)->
#          item.image  = AnalyticHelperService.randomImage()
#          item.duration = _.random(0, 5000)
#        $scope.topContent = result.data
#        $scope.options.totalItems = result.data.length
#      , $scope.param)

    $scope.loadData()

    return
  directive =
    restrict: 'E'
    scope   : {}
    templateUrl: '/template/analytic/directive/dashboard-UniqueUserPlayRequest/view.html'
    link    : link
  return directive
directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticHelperService','$state']
angular
  .module 'sbd-admin'
  .directive "uizaDashboardUniqueUserPlayRequest", directive
