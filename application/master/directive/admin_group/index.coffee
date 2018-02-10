directive = ($rootScope, $document) ->
  link = ($scope, element, attr) ->
    $scope.group = []
    getListGroup = ()->
      data = []
      try
        data = JSON.parse window.sessionStorage['permission-group']
      catch e
      return data

    $scope.$watch 'model',(data)->
      return unless data
      listGroup = getListGroup()
      _.map listGroup,(item)->
        if item.id in $scope.model and _.isArray($scope.model)
          item.active = true
        else
          item.active = false
      $scope.group = listGroup
    return
  directive =
    restrict: 'E'
    scope   :
      model: '=ngModel'
    templateUrl: '/template/master/directive/admin_group/view.html'
    link    : link
  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "sbdAdminGroup", directive