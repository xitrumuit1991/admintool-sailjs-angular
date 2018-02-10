_config = ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'admin',
    url : "",
    templateUrl : '/template/modulePage.html'
_config.$inject = [ "$stateProvider", "$urlRouterProvider",]

_run = ($rootScope)->
  $rootScope.leftSidebar = [
    title : 'My Account'
    href : 'admin.account'
    icon : 'fa fa-user'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
#  ,
#    title : 'Group'
#    href : 'admin.group'
#    icon : 'fa fa-users'
#    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
#  ,
#    title : 'User'
#    href : 'admin.user'
#    icon : 'fa fa-bug'
#    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ]

_run.$inject = ['$rootScope']
window.angular.module("sbd-admin").config _config
  .run _run
