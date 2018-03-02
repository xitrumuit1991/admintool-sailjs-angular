_config = ($stateProvider) ->
  $stateProvider.state "analytic.live-realtime",
    url : "/live-realtime"
    templateUrl : '/template/analytic/controller/live-realtime/view.html'
    controller : 'analytic.controller.live-realtime.Ctrl'
_config.$inject = ["$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, $http, ApiService, UtitService, $state, $timeout, $location, $interval) ->
  $scope.form = [
    title : 'Audience & DVR'
    key : 'audience'
    type : 'number'
  ,
    title : 'Minutes Viewed'
    key : 'minutes_viewed'
    type : 'number'
  ,
    title : 'Average Buffering Time per Minute (seconds)'
    key : 'average_buffering'
    type : 'number'
  ,
    title : 'Average Bitrate (kbps)'
    key : 'average_bitrate'
    type : 'number'
  ]
  $scope.data = {
    audience: 0
    minutes_viewed: 0
    average_buffering: 0
    average_bitrate : 0
  }
  return
_controller.$inject = ['$rootScope', '$scope', '$http', 'ApiService',
  'UtitService',
  '$state',
  '$timeout',
  '$location',
  '$interval'
]
window.app
  .config _config
  .run _run
  .controller 'analytic.controller.live-realtime.Ctrl', _controller
