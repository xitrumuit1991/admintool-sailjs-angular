_config = ($stateProvider, $urlRouterProvider) ->
  $stateProvider
  .state 'analytic',
  url : "",
#  templateUrl : '/template/modulePage.html'
  templateUrl : '/template/analytic/view.html'
_config.$inject = [ "$stateProvider", "$urlRouterProvider"]

_run = ($rootScope)->
  $rootScope.leftSidebar = [
    title : 'Content Report'
    href : 'analytic.content-report'
    icon : 'fa fa-pie-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
    submenu : [
      title : 'Top Content'
      href : 'analytic.content-report.top-content'
    ,
      title : 'Content Drop-off'
      href : 'analytic.content-report.content-drop-off'
    ]
  ,
    title : 'User & Communnity'
    href : 'analytic.user-community'
    icon : 'fa fa-line-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
    submenu : [
      title : 'Geographic'
      href : 'analytic.user-community.geographic'
    ]
  ,
    title : 'Systems Reports'
    href : 'analytic.system-report'
    icon : 'fa fa-area-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
    submenu : [
      title : 'OS Report'
      href : 'analytic.system-report.os'
      icon : 'fa fa-snowflake-o'
      bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
    ,
      title : 'Browser Report'
      href : 'analytic.system-report.browser'
      icon : 'fa fa-snowflake-o'
      bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
    ,
      title : 'Platform Report'
      href : 'analytic.system-report.platform'
      icon : 'fa fa-snowflake-o'
      bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
    ]
  ,
    title : 'Live Report'
    href : 'analytic.live-report'
    icon : 'fa fa-align-center'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ,
    title : 'Live Realtime Dashboard'
    href : 'analytic.live-realtime'
    icon : 'fa fa-snowflake-o'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ]

_run.$inject = ['$rootScope']
window.angular.module("sbd-admin").config _config
  .run _run
