#directive = (AnalyticService,ApiService, $rootScope, $document, UtitService, $timeout, AnalyticHelperService) ->
#  link = ($scope, element, attr) ->
#    $scope.traffics = []
#    $scope.pagination =
#      totalItems:0
#      currentPage:1
#      limit: 7
#      items : []
#      onPageChange:()->
#        start = ($scope.pagination.currentPage-1)*$scope.pagination.limit
#        end = start+$scope.pagination.limit
#        $scope.traffics = $scope.pagination.items.slice(start, end)
#
#
#    genPieChartConfig = (parentPie, title , key, colorBG)->
#      config = {
#        type: 'pie',
#        data: {
#          datasets: [{
#            data: [] #10, 20, 30
#            backgroundColor: []  #'red', 'orange' ,'green'
#            borderColor: 'rgba(200, 200, 200, 0.75)',
#            hoverBorderColor: 'rgba(200, 200, 200, 1)',
#            label: 'Chart label'
#          }],
#          labels: [ ] #"A", "B", "C"
#        },
#        options: {
#          title: {
#            display: true,
#            fontsize: 14,
#            text: title
#          },
#          responsive: true
#        }
#      }
#      config.data.datasets[0].backgroundColor = colorBG
#      _.map parentPie,(item)->
#        config.data.labels.push(item.name)
#        config.data.datasets[0].data.push(item[key])
#      return config
#
#    $scope.modalBusinessTrafficPieChart =
#      id : 'modalBusinessTrafficSourcePieChart'
#      show          : ()->
#        $("##{@.id}").modal('show')
#        colorBG = []
#        _.map $scope.traffics,(item)->
#          colorBG.push AnalyticHelperService.dynamicColors()
#        config = genPieChartConfig($scope.traffics, 'Display' , 'display', colorBG)
#        pieDisplay = new Chart(document.getElementById("businessTrafficSourceChart_display").getContext("2d"), config)
#        pieDisplay.update()
#
#        configPlayRequest = genPieChartConfig($scope.traffics, 'Play Request' , 'play_request', colorBG)
#        piePlayRequest = new Chart(document.getElementById("businessTrafficSourceChart_play_request").getContext("2d"), configPlayRequest)
#        piePlayRequest.update()
#
#        configVideoStart = genPieChartConfig($scope.traffics, 'Video Start' , 'video_start', colorBG)
#        pieVideo_start = new Chart(document.getElementById("businessTrafficSourceChart_video_start").getContext("2d"), configVideoStart)
#        pieVideo_start.update()
#      close         : ()->
#        $("##{@.id}").modal('hide')
#
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
#    $scope.loadData = ()->
#      AnalyticService.analytic.business.traffic((err, result)->
#        return if err or !result
#        $scope.pagination.items = result.data
#        $scope.pagination.totalItems = result.data.length
#        $scope.pagination.onPageChange()
#      ,$scope.param)
#
#    return
#  directive =
#    restrict : 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
#    templateUrl : Templates['analytic.directive.businessTrafficSource']()
#    link : link
#
#  return directive
#directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout','AnalyticHelperService' ]
#angular.module 'sb-admin'
#.directive "uizaBusinessTrafficSource", directive