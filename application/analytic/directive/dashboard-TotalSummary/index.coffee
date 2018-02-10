directive = (ApiService, $rootScope, $document, UtitService, $timeout, AnalyticService,AnalyticHelperService) ->
  link = ($scope, element, attr) ->
    $scope.totalSummary =  {
      "current_user":0,
      "user_today":9,
      "display":35,
      "play_request":0,
      "video_start":18,
      "play_conv_rate":0,
      "video_conv_rate": 0.25
      "avg_play_through":0.5694444444444444
    }

    $scope.fromData = [
      title  : 'Current User'
      key    : 'current_user'
      type   : 'number'
      tooltip: 'The number of concurrent users who are watching your video content right now'
      color  : '#90be2e'
    ,
      title  : 'User Today'
      key    : 'user_today'
      type   : 'number'
      color  : '#5bc0de'
      tooltip: 'The number of unique users you have today up to now'
    ,
      title  : 'Displays Today'
      key    : 'display'
      type   : 'number'
      color  : '#f0ad4e'
      tooltip: 'The number of Displays you have today up to now'
    ,
      title  : 'Plays requested today'
      key    : 'play_request'
      type   : 'number'
      color  : '#e65252'
      tooltip: 'The number of Plays Requested you have today up to now'
    ,
      title  : 'Video Starts Today'
      key    : 'video_start'
      type   : 'number'
      color  : '#3b75e3'
      tooltip: 'The number of Video Starts you have today up to now'
    ,
      title  : 'Play conversion rate'
      key    : 'play_conv_rate'
      type   : 'percent'
      color  : '#5bc0de'
      tooltip: 'Play Request/Display'
    ,
      title  : 'Video conversion rate'
      key    : 'video_conv_rate'
      type   : 'percent'
      color  : '#90be2e'
      tooltip: 'Video Start/Play Requested'
    ,
      title  : 'Avg. Playthrough'
      key    : 'avg_play_through'
      type   : 'percent'
      color  : '#f0ad4e'
      tooltip: 'Avg. Playthrough'
    ]

    $scope.param =
      start_date : AnalyticHelperService.startDate()
      end_date : AnalyticHelperService.endDate()

#    AnalyticService.analytic.totalSummary((err, result)->
#      return if err or !result
#      $scope.totalSummary = result.data
#    , $scope.param)
  
  directive =
    restrict: 'E'
    scope   : {}
    templateUrl: '/template/analytic/directive/dashboard-TotalSummary/view.html'
    link    : link
  return directive
directive.$inject = ['ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticService','AnalyticHelperService']
angular.module 'sbd-admin'
  .directive "sbdDashboardTotalSummary", directive