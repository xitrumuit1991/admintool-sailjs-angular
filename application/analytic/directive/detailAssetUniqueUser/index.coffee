#directive = (AnalyticService,ApiService, $rootScope, $document, UtitService, $timeout, $stateParams, AnalyticHelperService) ->
#  link = ($scope, element, attr) ->
#    entityId = $stateParams.id
#    $scope.uniqueUserChartOption = {
#      type: 'line'
#      data: {
#        labels : []
#        datasets : [{
#          label : 'Unique User'
#          fill : false
#          lineTension : 0
#          backgroundColor : '#fff'
#          borderColor : '#6896f9'
#          borderCapStyle : 'butt'
#          borderDash : []
#          borderDashOffset : 0.0
#          borderJoinStyle : 'miter'
#          pointBorderColor : '#fff'
#          pointBackgroundColor : '#2a2f37'
#          pointBorderWidth : 3
#          pointHoverRadius : 10
#          pointHoverBackgroundColor : '#FC2055'
#          pointHoverBorderColor : '#fff'
#          pointHoverBorderWidth : 3
#          pointRadius : 6
#          pointHitRadius : 10
#          data : []
#          spanGaps : false
#        }]
#      }
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
#                when 'play_rq'
#                  break
#                when 'hours_watched'
#                  return "#{label} : #{AnalyticHelperService.secondToHHmmss(value,'hh:mm:ss')}"
#                  break
#                when 'unique_user'
#                  break
#              return label + ': ' + value
##            footer: (tooltipItems, data)->
##              return ['new line', 'another line']
#          }
#        }
#        pan: {
#          enabled: false,
#          mode: 'xy',
#        },
#        zoom: {
#          enabled: false,
#          drag: false,
#          mode: 'xy',
#        }
#        scales: {
#          xAxes: [ {
#            ticks:
#              fontSize: '11'
#              fontColor: '#969da5'
#            gridLines:
#              color: 'rgba(0,0,0,0.05)'
#              zeroLineColor: 'rgba(0,0,0,0.05)'
#          } ]
#          yAxes: [{
#            scaleLabel:
#              display: true,
#              labelString: 'Unique User'
#            ticks: {
#              beginAtZero:false
#            }
#          }]
#        }
#      }
#    }
#
#    lineChart = document.getElementById("uniqueUserChart")
#    myLineChart = new Chart(lineChart,$scope.uniqueUserChartOption )
#
#    $scope.param =
#      entity_id: entityId
#      start_date: AnalyticHelperService.startDate()
#      end_date: AnalyticHelperService.endDate()
#      type : 'unique_user' #ex: play_rq, unique_user, hours_watched, play_through.
#      interval : '15m' #Time interval, ex: 15m, 1h, 1d, 1w, 1M.
#
#    $scope.changeLabelChart = (type)->
#      switch type
#        when 'play_through'
#          $scope.uniqueUserChartOption.data.datasets[0].label = 'Play Through'
#          $scope.uniqueUserChartOption.options.scales.yAxes[0].scaleLabel =
#            display: true,
#            labelString: 'Play Through %'
#          break
#        when 'play_rq'
#          $scope.uniqueUserChartOption.data.datasets[0].label = 'Plays Requested'
#          $scope.uniqueUserChartOption.options.scales.yAxes[0].scaleLabel =
#            display: true,
#            labelString: 'Plays Requested'
#          break
#        when 'hours_watched'
#          $scope.uniqueUserChartOption.data.datasets[0].label = 'Hours Watched'
#          $scope.uniqueUserChartOption.options.scales.yAxes[0].scaleLabel =
#            display: true,
#            labelString: 'Hours Watched'
#          break
#        when 'unique_user'
#          $scope.uniqueUserChartOption.data.datasets[0].label = 'Unique User'
#          $scope.uniqueUserChartOption.options.scales.yAxes[0].scaleLabel =
#            display: true,
#            labelString: 'Unique User'
#          break
##      console.log 'changeLabelChart',type
##      console.log '$scope.uniqueUserChartOption.data.datasets[0].label' , $scope.uniqueUserChartOption.data.datasets[0].label
#
#
#    $scope.changeInterval = (type)->
#      $scope.param.interval = type
#      $scope.loadData()
#
#    $scope.changeType = (type)->
#      $scope.param.type = type
#      $scope.loadData()
#
#    $scope.loadData = ()->
#      AnalyticService.analytic.video.uniqueUser((err, result)->
#        return if err or !result
#  #      console.warn('uniqueUser', result)
#        $scope.uniqueUserChartOption.data.labels = []
#        $scope.uniqueUserChartOption.data.datasets[0].data = []
#        _.map result.data, (item)->
#          date = moment( new Date(parseInt(item.time)) ).format('DD/MM/YYYY HH:mm')
#          $scope.uniqueUserChartOption.data.labels.push(date)
#          $scope.uniqueUserChartOption.data.datasets[0].data.push(item.value)
#        $scope.changeLabelChart($scope.param.type)
#        myLineChart.update()
#      ,$scope.param)
#
#
#    $scope.$watch 'start_date',(data)->
#      return unless data
#      if AnalyticHelperService.isDDMMYYYY(data)
#        $scope.param.start_date = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
#        $scope.loadData()
#
#    $scope.$watch 'end_date',(data)->
#      return unless data
#      if AnalyticHelperService.isDDMMYYYY(data)
#        $scope.param.end_date = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
#        $scope.loadData()
#
#    $scope.loadData()
#
#    return
#  directive =
#    restrict : 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
##    scope   : {}
##      item: '=ngModel'
#    templateUrl : Templates['analytic.directive.detailAssetUniqueUser']()
#    link : link
#
#  return directive
#directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', '$stateParams','AnalyticHelperService']
#angular.module 'sb-admin'
#.directive "uizaDetailAssetUniqueUser", directive
