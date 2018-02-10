#directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, $stateParams, AnalyticHelperService) ->
#  link = ($scope, element, attr) ->
#    entityId = $stateParams.id
#    chartSegmentWatched = null
#    $scope.resetZoom = ()->
#      chartSegmentWatched.resetZoom()
##      $scope.checkMax()
##      $scope.loadDataSegmentWatched
#    $scope.param =
#      entity_id : entityId
#      start_date : AnalyticHelperService.startDate()
#      end_date : AnalyticHelperService.endDate()
#
#    $scope.dataChartOption = {
#      type : 'line',
#      data : {
#        labels : [],
#        datasets : [{
#          label : "Segments Watched (Zoom Able)",
#          fill : true,
#          lineTension : 0,
#          backgroundColor : "#9db1ee",
#          borderColor : "#65a8f1",
#          borderCapStyle : 'butt',
#          borderDash : [],
#          borderDashOffset : 0.0,
#          borderJoinStyle : 'miter',
#          pointBorderColor : "white",
#          pointBackgroundColor : "black",
#          pointBorderWidth : 3,
#          pointHoverRadius : 6,
#          pointHoverBackgroundColor : "brown",
#          pointHoverBorderColor : "yellow",
#          pointHoverBorderWidth : 3,
#          pointRadius : 0,
#          pointHitRadius : 6,
#          data : [],
#          spanGaps : false
#        }]
#      },
#      options : {
#        maintainAspectRatio : false,
#        spanGaps : false,
#        legend:
#          display: true,
#          labels:
#            fontColor: "#000",
#        tooltips:
#          callbacks:
#            label: (tooltipItem, chartData)->
#              return 'Views : '+tooltipItem.yLabel
#        scales: {
#          xAxes: [{
#            ticks:
#              callback: (label, index, labels)->
##                console.log label
##                console.log index
##                console.log labels
#                return UtitService.secondToHHmmss(label)
#          }]
#          yAxes: [{
#            ticks: {
#              beginAtZero:true
#            }
#          }]
#        }
#        pan: {
#          enabled: true,
#          mode: 'x',
#        },
#        zoom : {
#          enabled : true,
#          drag : true,
#          mode : "x",
#        }
#      }
#    }
#
#    $scope.checkMax = ()->
#      max = 0
#      _.map $scope.dataChartOption.data.datasets[0].data, (item)->
#        if item and item > max then max = item
#      $scope.dataChartOption.options.scales.yAxes[0].ticks.max = Math.ceil(max*1.5)
#
#    $scope.loadDataSegmentWatched = ()->
#      AnalyticService.analytic.video.segments_watched((err, result)->
#        return if err or !result or !result.data
#        $scope.dataChartOption.data.labels = []
#        $scope.dataChartOption.data.datasets[0].data = []
##        console.log('$scope.$parent.itemVideoInfo: ', $scope.$parent.itemVideoInfo)
#        _.map result.data, (item)->
#          if $scope.$parent.itemVideoInfo
#            $scope.dataChartOption.data.labels.push(parseInt(item.time * $scope.$parent.itemVideoInfo.duration / 100))
#          $scope.dataChartOption.data.datasets[0].data.push(item.value)
#        if _.isEmpty(chartSegmentWatched) or !chartSegmentWatched
#          chartSegmentWatched = new Chart(document.getElementById("segments_watched_chart").getContext('2d'), $scope.dataChartOption)
#        else
#          chartSegmentWatched.update()
#        $scope.checkMax()
#      , $scope.param)
#
#    $scope.$watch 'start_date',(data)->
#      return unless data
#      if AnalyticHelperService.isDDMMYYYY(data)
#        $scope.param.start_date = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
#        $scope.loadDataSegmentWatched()
#
#    $scope.$watch 'end_date',(data)->
#      return unless data
#      if AnalyticHelperService.isDDMMYYYY(data)
#        $scope.param.end_date = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
#        $scope.loadDataSegmentWatched()
#
#    #call
#    $scope.loadDataSegmentWatched()
#
#    return
#  directive =
#    restrict : 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
#    templateUrl : Templates['analytic.directive.detailAssetSegmentWatched']()
#    link : link
#  return directive
#directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', '$stateParams', 'AnalyticHelperService']
#angular
#  .module 'sb-admin'
#  .directive "uizaDetailAssetSegmentWatched", directive
