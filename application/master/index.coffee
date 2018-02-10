_config = ($stateProvider, $urlRouterProvider) ->
_config.$inject = [ "$stateProvider", "$urlRouterProvider",]

_run = ($rootScope)->
  $rootScope.$watch 'topSidebar',(data)->
    return unless data
    _.map data,(item)->
      item.home = true
    $rootScope.leftSidebar = data
  return
_run.$inject = ['$rootScope']
window.angular.module("sbd-admin").config _config
  .run _run
