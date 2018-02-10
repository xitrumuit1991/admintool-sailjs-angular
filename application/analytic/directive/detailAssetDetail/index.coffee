#directive = (AnalyticService,ApiService, $rootScope, $document, UtitService, $timeout, $stateParams, AnalyticHelperService) ->
#  link = ($scope, element, attr) ->
#    entityId = $stateParams.id || AnalyticHelperService.randomUuid()
#    $scope.itemVideoInfo=null
#    $scope.dataDetail = null
#
#    $scope.detailfromData = [
#      title  : 'Unique Users'
#      key    : 'unique_user'
#      type   : 'number'
#      tooltip: 'The number of unique users who request to play selected videos'
#      color  : '#90be2e'
#    ,
#      title  : 'Play Requested'
#      key    : 'play_request'
#      type   : 'number'
#      color  : '#5bc0de'
#      tooltip: 'The number of time that the Play button is triggered either manually or automatically'
##    ,
##      title  : 'Hours Watched'
##      key    : 'hours_watched'
##      type   : 'time'
##      color  : '#f0ad4e'
##      tooltip: 'Hour watched/Video start, convert to HH:MM:SS format'
#    ,
#      title  : 'Avg. Playthrough'
#      key    : 'avg_play_through'
#      type   : 'percent'
#      color  : '#e65252'
#      tooltip: 'Total play requested/Total unique user ( for the select date range)'
#    ]
#
#    $scope.formVideoInfo=[
#      title  : 'Uploaded:'
#      key    : 'updatedAt'
#      type   : 'date'
#    ,
#      title  : 'Length:'
#      key    : 'duration'
#      type   : 'time'
##    ,
##      title  : 'Content Type:'
##      key    : 'contentType'
##      type   : 'text'
##      value : 'vod'
#    ,
#      title  : 'Video ID:'
#      key    : 'id'
#      type   : 'text'
#    ,
#      title  : 'Description:'
#      key    : 'description'
#      type   : 'text'
#    ]
#
#    $scope.param =
#      entity_id: entityId
#      start_date: AnalyticHelperService.startDate()
#      end_date: AnalyticHelperService.endDate()
#
#    $scope.loadData = ()->
#      AnalyticService.analytic.video.summary((err, result)->
##        console.warn 'asset detail; summary=', result
#        return if err or !result
#        $scope.dataDetail = result.data
#      ,$scope.param)
#      AnalyticService.analytic.video.info((err, result)->
#        return if err or !result
#        $scope.itemVideoInfo = $scope.$parent.itemVideoInfo = result.item
#      ,$scope.param)
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
#
#    return
#  directive =
#    restrict : 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
##    scope   :
##      item: '=ngModel'
#    templateUrl : Templates['analytic.directive.detailAssetDetail']()
#    link : link
#
#  return directive
#directive.$inject = ['AnalyticService','ApiService', '$rootScope', '$document', 'UtitService', '$timeout', '$stateParams', 'AnalyticHelperService']
#angular.module 'sb-admin'
#.directive "uizaDetailAssetDetail", directive
