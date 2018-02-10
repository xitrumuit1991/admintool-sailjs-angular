directive = (ApiService, $rootScope, $document, UtitService, $timeout, $state) ->
  link = ($scope, element, attr) ->

    if $state.current
      $scope.typeView = $state.current.name
    if !$scope.typeView
      $scope.typeView = 'analytic'

    $scope.$watch (->
      $scope.typeView = $state.current.name
    ), (newVal, oldVal) ->
      return

    $scope.changeView = (type)->
      $state.go type , {},{reload: true}

    return
  directive =
    restrict : 'E'
    scope   : {}
    templateUrl  : '/template/analytic/directive/analytic-nav-view/view.html'
    link : link
  return directive
directive.$inject = ['ApiService', '$rootScope', '$document', 'UtitService', '$timeout', '$state']
angular
.module 'sbd-admin'
.directive "sbdDashboardNavView", directive
