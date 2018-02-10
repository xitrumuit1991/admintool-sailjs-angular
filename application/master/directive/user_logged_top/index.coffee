directive = ($rootScope, $document) ->
  link = ($scope, element, attr) ->
    $rootScope.$watch 'user', (data)->
      return unless data
      $scope.user = data

    $scope.logoutFE = ()->
      window.localStorage.clear()
      window.sessionStorage.clear()
      return window.location.href = '/logout'

    return
  directive =
    restrict: 'E'
    scope:{}
    templateUrl: '/template/master/directive/user_logged_top/view.html'
    link    : link
  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "sbdUserLoggedTop", directive