#directive = (ApiService, $rootScope, $document, UtitService, $timeout, AnalyticService, AnalyticHelperService) ->
#  link = ($scope, element, attr) ->
#    genPieChartConfig = (parentPie, title , key, colorBG)->
#      config = {
#        type: 'pie',
#        data:
#          datasets: [{
#            data: [] #10, 20, 30
#            backgroundColor: []  #'red', 'orange' ,'green'
#            borderColor: 'rgba(200, 200, 200, 0.75)',
#            hoverBorderColor: 'rgba(200, 200, 200, 1)',
#            label: 'Chart label'
#          }],
#          labels: [ ] #"A", "B", "C"
#        options:
#          title:
#            display: true,
#            fontsize: 14,
#            text: title
#          responsive: true
#      }
#      config.data.datasets[0].backgroundColor = colorBG
#      _.map parentPie,(item)->
#        config.data.labels.push(item.name)
#        config.data.datasets[0].data.push(item[key])
#      return config
#
#    $scope.modalPieChart =
#      id : 'modal-pie-chart'
#      show          : ()->
#        $("##{@.id}").modal('show')
#        parentPie = _.filter $scope.device, {isParent : true}
#        colorBG = []
#        _.map parentPie,(item)->
#          colorBG.push AnalyticHelperService.dynamicColors()
#
#        config = genPieChartConfig(parentPie, 'Display' , 'display', colorBG)
#        pieDisplay = new Chart(document.getElementById("businessDeviceChart_display").getContext("2d"), config)
#        pieDisplay.update()
#
#        configPlayRequest = genPieChartConfig(parentPie, 'Play Request' , 'play_request', colorBG)
#        piePlayRequest = new Chart(document.getElementById("businessDeviceChart_play_request").getContext("2d"), configPlayRequest)
#        piePlayRequest.update()
#
#        configVideoStart = genPieChartConfig(parentPie, 'Video Start' , 'video_start', colorBG)
#        pieVideo_start = new Chart(document.getElementById("businessDeviceChart_video_start").getContext("2d"), configVideoStart)
#        pieVideo_start.update()
#      close         : ()->
#        $("##{@.id}").modal('hide')
#
#    $scope.device = []
#    $scope.param =
#      start_date: AnalyticHelperService.startDate()
#      end_date: AnalyticHelperService.endDate()
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
#    $scope.expandRow = (ite)->
#      _.map $scope.device,(item)->
#        if item.belongTo == ite.name
#          item.show = true
#        else if item.belongTo and item.belongTo != ite.name
#          item.show = false
#
#    $scope.loadData = ()->
#      AnalyticService.analytic.business.device((err, result)->
#        return if err or !result
#        _.map result.data, (item)->
#          item.display = 0
#          item.play_request = 0
#          item.video_start = 0
#          item.isParent = true
#          _.map item.value, (oneOs)->
#            item.display += oneOs.display
#            item.play_request += oneOs.play_request
#            item.video_start += oneOs.video_start
#            oneOs.belongTo = item.name
#            oneOs.name = oneOs.os
#            oneOs.show = false
#
##        console.log 'result.data',result.data
#        $scope.device=[]
#        _.map result.data , (item)->
#          $scope.device.push(item)
#          _.map item.value, (oneOs)->
#            if oneOs.belongTo == item.name
#              $scope.device.push(oneOs)
##        console.log '$scope.device',$scope.device
##        $scope.device = result.data
#      ,$scope.param)
#
#
#    return
#  directive =
#    restrict : 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
#    templateUrl : '/template/analytic/directive/business-Device/view.html'
#    link : link
#
#  return directive
#directive.$inject = ['ApiService', '$rootScope', '$document', 'UtitService', '$timeout' , 'AnalyticService', 'AnalyticHelperService']
#angular.module 'sb-admin'
#.directive "uizaBusinessDevice", directive