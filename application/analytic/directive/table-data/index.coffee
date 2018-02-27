directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, AnalyticHelperService, $state) ->
  link = ($scope, element, attr)->
    initForm = [
      title : 'Video'
      type  : 'text'
      key : 'video'
    ,
      title : 'Play'
      key : 'play'
      type  : 'number'
    ,
      title : 'Minutes Viewed'
      key : 'minutes_viewed'
      type  : 'time'
    ,
      title : 'Avg. View Time'
      key : 'avg_view_time'
      type  : 'time'
    ,
      title : 'Player Impressions'
      key : 'player_impressions'
      type  : 'number'
    ,
      title : 'Play to Impression Ratio'
      type  : 'percent'
      key : 'play_to_impression_ratio'
    ,
      title : 'Avg. View Drop-off'
      type  : 'percent'
      key : 'avg_view_drop_off'
    ]

    initData = [
      video : 'Name video'
      play : 10
      minutes_viewed: 1769
      avg_view_time: 361
      player_impressions:10
      play_to_impression_ratio: 100
      avg_view_drop_off: 35
    ,
      video : 'Name video 2'
      play : 11
      minutes_viewed: 1777
      avg_view_time: 315
      player_impressions:21
      play_to_impression_ratio: 90
      avg_view_drop_off: 35.5
    ]

    $scope.$watch 'form',(data)->
      $scope.form = initForm unless data

    $scope.$watch 'data',(data)->
      $scope.data = initData unless data

    return null
  directive =
    restrict : 'E'
    scope :
      form : '=ngForm'
      data : '=ngData'
    templateUrl : '/template/analytic/directive/table-data/view.html'
    link : link
  return directive
directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticHelperService', '$state']
angular
  .module 'sbd-admin'
  .directive "sbdTableData", directive