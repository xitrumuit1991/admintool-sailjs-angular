_directive = (ApiAdminService) ->
  link = ($scope, $element, $attr) ->
    group = []
    $scope.permissionList =
      active: false
      list  : []
    
    $scope.selectItem = (name)->
      if name is 'all'
        _.map $scope.permissionList.list, (item)->
          item.active = $scope.permissionList.active
      _.map $scope.permissionList.list, (item)->
        if name is 'all' or item.title is name
          _.map item.items, (data)->
            data.active = item.active
      null


    $scope.getDataOut = ()->
      data = []
      data = _.map($scope.permissionList.list, 'items')
      data = _.flatten data
      data = _.filter data,(item)->
        return item.active is true
      data = _.map data, (item)-> item.permission
      $scope.dataOut = data
      console.log '$scope.dataOut', $scope.dataOut

    $scope.$watch 'permissionList.list', (data)->
      return unless data
      $scope.getDataOut()
    , true


    ApiAdminService.permissionList {page:1, limit: 1000},(error, result)->
      return if error or !result
      _.map result,(item)->
        item.permission = item.permission[0].name if item.permission and item.permission[0]
      perGroup = _.groupBy result, 'group'
      _.map perGroup, (value, key)->
        $scope.permissionList.list.push(
          title : key
          active: false
          items : value
        )
      _.map $scope.permissionList.list, (group)->
        _.map group.items,(oneItem)->
          if $scope.actionList and oneItem.permission and oneItem.permission in $scope.actionList
            oneItem.active = true
          else
            oneItem.active = false
          indexFind = _.findIndex(group.items,{ active : false})
          if indexFind == -1 then group.active = true else group.active = false

  directive =
    restrict: 'E'
    scope   :
      actionList: '=ngModel'
      dataOut   : '=ngDataOut'
    templateUrl: '/template/admin/directive/permissionList/view.html'
    link    : link
  
  return directive
_directive.$inject = ['ApiAdminService']
angular
  .module 'sbd-admin'
  .directive "permissionList", _directive