directive = ($rootScope, $document) ->
  link = ($scope, element, attr) ->
    $scope.goLink = (link)->
      return window.location.href = link;

    $rootScope.$watch 'topSidebar',(data)->
      return unless data
      if $scope.type == 'homePage'
        $scope.menuHomeBlock = $rootScope.topSidebar
      if $scope.type == 'modulePage'
        $scope.menuHomeBlock = $rootScope.leftSidebar
    return null
  directive =
    restrict: 'E'
    scope:
      type : '=ngType'
    templateUrl: '/template/master/directive/home_block/view.html'
    link    : link
  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "sbdHomeBlock", directive