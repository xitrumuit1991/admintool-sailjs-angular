#directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, AnalyticHelperService, $state) ->
#  link = ($scope, element, attr) ->
#    $scope.assetInfo = []
#    $scope.options =
#      loading    : true
#      totalItems : 100
#      currentPage: 1
#      limit      : 6
#      offset     : 0
#
#    $scope.onPageChange = ()->
#      $scope.options.offset = $scope.options.limit * ($scope.options.currentPage - 1)
#      UtitService.apply($scope)
#
#    $scope.goToDetailAssets = (item, index)->
##      console.log 'goToDetailAssets',item
#      $state.go 'analytic.detail-asset',{id : item.entity_id}, {reload:true}
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
#      AnalyticService.analytic.business.assetVideo((err, result)->
#        $scope.options.loading = false
#        return if err
#        _.map result.data, (item)->
#          item.image = item.thumbnail || item.poster || 'http://via.placeholder.com/135x75'
#        $scope.assetInfo = result.data
#        $scope.options.totalItems = $scope.assetInfo.length
#      , $scope.param)
#    return
#  directive =
#    restrict: 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
#    templateUrl: '/template/analytic/directive/business-AssetVideo/view.html'
#    link    : link
#
#  return directive
#directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticHelperService','$state']
#window.app.directive "uizaBusinessAssetVideos", directive
