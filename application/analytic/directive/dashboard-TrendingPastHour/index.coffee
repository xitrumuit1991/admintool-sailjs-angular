directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, AnalyticHelperService,$state) ->
  link = ($scope, element, attr) ->
    $scope.items = [
      {
        name: ''
        image: ''
        duration: ''
        value: ''
      }
    ]
    randomData = ()->
      $scope.items = []
      $scope.form.loading = false
      _.map [0..5],(index)->
        $scope.items.push({
          name : AnalyticHelperService.randomName()
          image : AnalyticHelperService.randomImage()
          id : AnalyticHelperService.randomUuid()
          entity_id : AnalyticHelperService.randomUuid()
          duration : _.random(0,3600)
          value : _.random(0,100)
        })

    $scope.form =
      class : 'box-info'
      title      : 'Trending Past Hour'
      tooltip    : 'The Trending Past Hour section show the top video with the largest percentage increase in engagement in the last 60 minutes.'
      loading    : true
      totalItems : 100
      currentPage: 1
      limit      : 4
      offset     : 0
      onPageChange : ()->
#        $scope.form.offset = $scope.form.limit * ($scope.form.currentPage - 1)
        randomData()
      detailAsset: (item, index)->
        $state.go 'analytic.detail-asset',{id : item.entity_id}, {reload:true}

    $scope.param =
      start_date : AnalyticHelperService.startDate()
      end_date : AnalyticHelperService.endDate()


    randomData()
#    AnalyticService.analytic.popularNow((err, result)->
#      $scope.form.loading = false
#      return if err or !result
#      _.map result.data ,(item)->
#        item.image  = item.thumbnail || item.poster || 'http://via.placeholder.com/135x75'
#      $scope.data = result.data
#      $scope.options.totalItems = $scope.data.length
#    , $scope.param)
  
  directive =
    restrict: 'E'
    scope   : {}
#      item: '=ngModel'
    templateUrl: '/template/analytic/directive/dashboard-TrendingPastHour/view.html'
    link    : link
  return directive
directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticHelperService','$state']
angular
  .module 'sbd-admin'
  .directive "sbdDashboardTrendingPastHour", directive