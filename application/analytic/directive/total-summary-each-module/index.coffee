directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, AnalyticHelperService, $state) ->
  link = ($scope, element, attr)->
    initForm = [
      title : 'Play'
      type  : 'number'
      key : 'play'
      value : 8
    ,
      title : 'Minutes Viewed'
      type  : 'time'
      key : 'minutes_viewed'
      value : 1840 #second
    ,
      title : 'Avg. View Time'
      type  : 'time'
      key : 'avg_view_time'
      value : 78 #second
    ,
      title : 'Player Impressions'
      type  : 'number'
      key : 'player_impressions'
      value : 9
    ,
      title : 'Play to Impression Ratio'
      type  : 'percent'
      key : 'play_to_impression_ratio'
      value : 100 #%
    ,
      title : 'Avg. View Drop-off'
      type  : 'percent'
      key : 'avg_view_drop_off'
      value : 68.75 #%
    ]

    initData = {
      play : 8
      minutes_viewed : 1840
      avg_view_time : 78
      player_impressions:9
      play_to_impression_ratio:100
      avg_view_drop_off: 68.75
    }

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
    templateUrl : '/template/analytic/directive/total-summary-each-module/view.html'
    link : link
  return directive
directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticHelperService', '$state']
angular
  .module 'sbd-admin'
  .directive "sbdTotalSummaryEachModule", directive