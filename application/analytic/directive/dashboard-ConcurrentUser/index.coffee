directive = (ApiService, $rootScope, $document, UtitService, $timeout, AnalyticService, $interval, AnalyticHelperService) ->
  link = ($scope, element, attr) ->
    $scope.dataTooltip = 'The number of concurrent users who are watching your video content right now or in the last 4 hour'
    intervalGetDate = null
    numberPointInChart = 20
    $scope.optionChart = {
      type: 'line',
      data: {
        labels: [],
        datasets: [{
          label: "Concurrent User",
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
          data: [],
          spanGaps: false
        }]
      },
      options: {
        maintainAspectRatio: false,
        spanGaps: false,
        scales: {
          yAxes : [{
            ticks : {
              beginAtZero:true
              max : 1,
              min : 0
            }
          }]
        }
      }
    }

    concurrentUserChart = new Chart(document.getElementById("concurrentUserChart"), $scope.optionChart)

    checkMaxValue = ()->
      max = 0
      _.map $scope.optionChart.data.datasets[0].data,(item)->
        max = parseInt(item) if !_.isUndefined(item) and max < parseInt(item)
      $scope.optionChart.options.scales.yAxes[0].ticks.max = Math.ceil(max*1.5)

    orderChart = (type = 'value', result)->
      time = result.data.time
      value = result.data.value
      return if !time or _.isUndefined(value) or _.isNull(value)
      if type is 'value'
        $scope.optionChart.data.datasets[0].data.push(value)
        tmpArr = []
        if $scope.optionChart.data.datasets[0].data.length > numberPointInChart
          _.map [0..numberPointInChart],(index)->
            dataPlusOne = $scope.optionChart.data.datasets[0].data[index+1]
            tmpArr[index] = dataPlusOne if !_.isUndefined(dataPlusOne)
          $scope.optionChart.data.datasets[0].data = tmpArr

      if type is 'label'
        date = moment(time).format("HH:mm:ss")
        return if !date
        $scope.optionChart.data.labels.push(date)
        tmpLabel = []
        if $scope.optionChart.data.labels.length > numberPointInChart
          _.map [0..numberPointInChart],(index)->
            dataPlusOne = $scope.optionChart.data.labels[index+1]
            tmpLabel[index] = dataPlusOne if !_.isUndefined(dataPlusOne)
          $scope.optionChart.data.labels = tmpLabel
      checkMaxValue()
      concurrentUserChart.update()

    $scope.param =
      start_date : AnalyticHelperService.startDate()
      end_date : AnalyticHelperService.endDate()

    $scope.getLineCountCurrentUser = (cb = null)->
      result =
        "code":0,
        "data" : {
          "time" : (new Date()).getTime(),
          "value":_.random(50,1000)
        },
        "msg":"Successfully"
      orderChart('value', result)
      orderChart('label', result)
      return cb() if _.isFunction(cb)

#      AnalyticService.analytic.concurrent((err, result)->
#        return if err or !result
#        orderChart('value', result)
#        orderChart('label', result)
#        return cb() if _.isFunction(cb)
#      , $scope.param)

    task = []
    _.map [0..numberPointInChart],(index)->
      task[index] = (cb)->
        $scope.getLineCountCurrentUser ()->
          $timeout(()->
            cb()
          ,1000)

    async.series task, (err) ->
      intervalGetDate = $interval(()->
        $scope.getLineCountCurrentUser()
      , 3000)

    $scope.$on '$destroy', ()->
      $interval.cancel(intervalGetDate) if intervalGetDate

    return
  directive =
    restrict: 'E'
    scope   : {}
    templateUrl: '/template/analytic/directive/dashboard-ConcurrentUser/view.html'
    link    : link

  return directive
directive.$inject = ['ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticService'
, '$interval' , 'AnalyticHelperService'
]
angular.module 'sbd-admin'
  .directive "sbdDashboardConcurrentUser", directive
