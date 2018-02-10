#directive = (ApiService, $rootScope, $document, UtitService, $timeout, $state) ->
#  link = ($scope, element, attr) ->
#    $scope.typeView = 'analytic'
#    $scope.typeView = $state.current.name
#    $scope.changeView = (type)->
#      $state.go type , {},{reload: true}
#
#    $scope.showOnDomain = ()->
#      host = window.location.host
#      if host.indexOf('localhost') >= 0 or host.indexOf('dev-app.uiza.io') >= 0 or host.indexOf('topica.uiza.io') >= 0 or host.indexOf('uqc.uiza.io') >= 0
#        return true
#      return false
#
#    return
#  directive =
#    restrict : 'E'
#    scope   : {}
##      type: '='
#    templateUrl : ''
#    link : link
#
#  return directive
#directive.$inject = ['ApiService', '$rootScope', '$document', 'UtitService', '$timeout', '$state']
#window.app
#.directive "uizaDashboardNavView", directive
