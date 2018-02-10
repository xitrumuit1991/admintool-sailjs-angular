directive = ($rootScope, $document) ->
  link = ($scope, element, attr) ->
#    $scope.fromData = [
#      title  : 'Current User'
#      key    : 'current_user'
#      type   : 'currency'
#      tooltip: 'This is current user'
#      color  : '#90be2e'
#    ,
#      title  : 'User Today'
#      key    : 'user_today'
#      type   : 'currency'
#      color  : '#5bc0de'
#      tooltip: 'This is user today'
#    ,
#      title  : 'Displays Today'
#      key    : 'display'
#      type   : 'currency'
#      color  : '#f0ad4e'
#      tooltip: 'This is current Displays Today'
#    ,
#      title  : 'Plays requested today'
#      key    : 'play_request'
#      type   : 'currency'
#      color  : '#e65252'
#      tooltip: 'This is Plays requested today'
#    ,
#      title  : 'Video Starts Today'
#      key    : 'video_start'
#      type   : 'currency'
#      color  : '#3b75e3'
#      tooltip: 'This is Video Starts Today'
#    ,
#      title  : 'Video conversion rate'
#      key    : 'video_conv_rate'
#      type   : 'precentage'
#      color  : '#90be2e'
#      tooltip: 'This is Video conversion rate'
#    ,
#      title  : 'Play conversion rate'
#      key    : 'play_conv_rate'
#      type   : 'precentage'
#      color  : '#5bc0de'
#      tooltip: 'This is Play conversion rate'
#    ,
#      title  : 'Avg. playthough'
#      key    : 'avg_play_through'
#      type   : 'precentage'
#      color  : '#f0ad4e'
#      tooltip: 'This is Avg. playthough'
#    ]
    $scope.checkInfinity = (value)->
      return if !value or _.isEmpty(value) or _.isUndefined(value)
      if value.indexOf('Infinity%') >= 0
        return '0%'
      if value.indexOf('Infinity') >= 0
        return '0'
      if value and !_.isEmpty(value)
        return value
    return
  directive =
    restrict: 'E'
    scope   :
      formData: '=ngFormData'
      model : '=ngModel'
    templateUrl: '/template/analytic/directive/list-color-analytic/view.html'
    link    : link

  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "listColorAnalytic", directive