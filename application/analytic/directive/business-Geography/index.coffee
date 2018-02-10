#directive = (ApiService, $rootScope, $document, UtitService, $timeout, AnalyticService, AnalyticHelperService) ->
#  link = ($scope, element, attr) ->
#
#    initDataChartGeo = [
#      serialBar : 'Display'
#      data : []
#      color :
#        backgroundColor : '#383d4d',
#        pointBackgroundColor : '#383d4d'
#        borderColor: '#383d4d',
#      isActive : true
#      type : 'display'
#    ,
#      serialBar : 'Play Request'
#      data : []
#      color :
#        backgroundColor : '#90be2e',
#        pointBackgroundColor : '#90be2e'
#        borderColor: '#90be2e',
#      isActive : true
#      type : 'playRequest'
#    ,
#      serialBar : 'Video Start'
#      data : []
#      color:
#        backgroundColor : '#097cff',
#        pointBackgroundColor : '#097cff'
#        borderColor: '#097cff',
#      isActive : true
#      type : 'videoStart'
#    ]
#
#    $scope.param =
#      start_date : AnalyticHelperService.startDate()
#      end_date : AnalyticHelperService.endDate()
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
#    $scope.changeViewGeo = (type)->
#      switch type
#        when 'all'
#          _.map initDataChartGeo,(item)->
#            item.isActive = true
#          break
#        when 'display', 'playRequest', 'videoStart'
#          _.map initDataChartGeo,(item)->
#            if item.type == type
#              item.isActive = true
#            else
#              item.isActive = false
#          break
#      $scope.loadData()
##      console.log 'initDataChartGeo',initDataChartGeo
#
#    $scope.loadData = ()->
#      $scope.labelsCanvas = []
#      $scope.seriesCanvas = []
#      $scope.chartColors = []
#      _.map initDataChartGeo,(item)->
#        if item.isActive
#          $scope.seriesCanvas.push(item.serialBar)
#          $scope.chartColors.push(item.color)
#      AnalyticService.analytic.business.geography((err, result)->
#        return if err or !result
#        _.map initDataChartGeo, (item)-> item.data = []
#        i = 0
#        while i < result.data.length and i < 5
#          ite = result.data[i]
#          $scope.labelsCanvas[i] = ite.name
#          _.map initDataChartGeo, (item)->
#            if item.isActive and item.type == 'display'
#              item.data.push(ite.display)
#            if item.isActive and item.type == 'playRequest'
#              item.data.push(ite.play_request)
#            if item.isActive and item.type == 'videoStart'
#              item.data.push(ite.video_start)
#          i++
#
#        $scope.dataCanvas = []
#        _.map initDataChartGeo, (item)->
#          $scope.dataCanvas.push(item.data) if item.isActive
#      , $scope.param)
#
#
#    return
#  directive =
#    restrict : 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
#    templateUrl : '/template/analytic/directive/business-Geography/view.html'
#    link : link
#
#  return directive
#directive.$inject = ['ApiService', '$rootScope', '$document', 'UtitService', '$timeout'
#, 'AnalyticService', 'AnalyticHelperService'
#]
#angular.module 'sb-admin'
#  .directive "uizaBusinessGeography", directive
