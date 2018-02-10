_config = ($stateProvider, $urlRouterProvider) ->
  $stateProvider
  .state 'analytic',
  url : "",
#  templateUrl : '/template/modulePage.html'
  templateUrl : '/template/analytic/view.html'
_config.$inject = [ "$stateProvider", "$urlRouterProvider"]

_run = ($rootScope)->
  $rootScope.leftSidebar = [
    title : 'Dashboard '
#    href : 'analytic.dashboard'
    href : 'analytic'
    icon : 'fa fa-pie-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ,
    title : 'Business'
    href : 'analytic.business'
    icon : 'fa fa-bar-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ,
    title : 'Line chart'
    href : 'analytic.line-chart'
    icon : 'fa fa-line-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ]

_run.$inject = ['$rootScope']
window.angular.module("sbd-admin").config _config
  .run _run
