directive = ($rootScope, $document) ->
  link = ($scope, element, attr) ->
    $rootScope.$watch 'user',(data)->
      return unless data
      $scope.user = data

    $rootScope.$watch 'leftSidebar',(data)->
      return unless data
      $scope.menuleft = $rootScope.leftSidebar


    return null
  directive =
    restrict: 'E'
#    scope:
#      save : '='
#      cancel : '='
    templateUrl: '/template/master/directive/left_menu_sidebar/view.html'
    link    : link
  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "sbdLeftMenuSidebar", directive