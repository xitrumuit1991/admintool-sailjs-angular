route = ($stateProvider) ->
  route = 'admin.user'
  template = '/template/admin/controller/user/action/view.html'
  controller = 'admin.controller.user.action'
  $stateProvider.state "#{route}.update",
    url       : "/update/:id",
    templateUrl  : template
    controller: controller
  $stateProvider.state "#{route}.create",
    url       : "/create",
    templateUrl  : template
    controller: controller

route.$inject = ['$stateProvider']
ctrl = (UtitService, $scope, $rootScope, $http, $stateParams, $state, ApiAdminService)->
  action = $state.current.name.match(/update|create|view/gi)[0]
  $scope.item = {}
  $scope.listGroup = []

  $scope.submit = ()->
    $scope.item.belongGroup = _.map(_.filter($scope.listGroup,(item)-> return item.active),'id')
    console.log '$scope.item',$scope.item
    ApiAdminService.user[action] $scope.item,(error, result)->
      console.log 'ApiAdminService.user submit', result
      return if error or !result
      if action is 'create'
        UtitService.notifySuccess 'Created successfull'
        return $state.go 'admin.user.update', {id: result.id}
      UtitService.notifySuccess 'Updated successfull'

  $scope.form = {
    data   : [
      title: "#{action} User"
      col  : '6'
      icon : 'fa fa-user'
      class: 'box-info'
      form : [
        title   : 'ID'
        key     : 'id'
        type    : 'text'
        readonly: true
      ,
        title   : 'Name'
        key     : 'name'
        type    : 'text'
        required: true
      ,
        title   : 'Email'
        key     : 'email'
        type    : 'text'
        required: true
      ,
        title   : 'Phone'
        key     : 'phone'
        type    : 'text'
      ,
        title: 'Password'
        key  : 'password'
        type : 'password'
      ,
        title: 'Status'
        key  : 'status'
        type : 'checkbox'
      ]
    ]
  }


  $scope.getGroupList = ()->
    ApiAdminService.group.list {page:1 , limit:1000}, (error, result)->
      return if error or !result
      $scope.listGroup = result.items
      console.log '$scope.listGroup=',$scope.listGroup

      ApiAdminService.permissionList {},(error, allPermission)->
        console.log 'permissionList=',allPermission
        return if error or !allPermission
        _.map $scope.listGroup, (oneGroup)->
          tmpPermissionOfGroup = []
          _.map oneGroup.permissionList,(perPath)->
            index = _.findIndex(allPermission,{ url :  perPath})
            tmpPermissionOfGroup.push(allPermission[index]) if index != -1
          oneGroup.permissionList = tmpPermissionOfGroup

      if action is 'update'
        _.map $scope.item.belongGroup , (oneGroupId)->
          index = _.findIndex($scope.listGroup, {id: oneGroupId})
          if index != -1 and $scope.listGroup[index]
            $scope.listGroup[index].active = true

  if action in ['update']
    ApiAdminService.user.get {id: $stateParams.id},(error, resultUser)->
      return if error or !resultUser
      $scope.item = resultUser
      console.log '$scope.item user=',$scope.item
      $scope.getGroupList()

  if action in ['create']
    $scope.getGroupList()


  return
ctrl.$inject = ['UtitService', '$scope', '$rootScope', '$http', '$stateParams', '$state','ApiAdminService']
angular.module 'sbd-admin'
  .config route
  .controller "admin.controller.user.action", ctrl
