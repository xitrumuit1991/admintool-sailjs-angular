directive = ($rootScope, $document) ->
  link = ($scope, element, attr) ->
    $rootScope.$watch 'topSidebar',(data)->
      return unless data
      $scope.topmenu = $rootScope.topSidebar

    return null
  directive =
    restrict: 'E'
#    scope:
#      save : '='
#      cancel : '='
    templateUrl: '/template/master/directive/menu_fix_top/view.html'
    link    : link
  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "sbdMenuFixTop", directive