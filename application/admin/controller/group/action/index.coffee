route = ($stateProvider) ->
  route = 'admin.group'
  template = '/template/admin/controller/group/action/view.html'
  controller = 'admin.controller.group.action'
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
  $scope.dataPermission = []
  $scope.item =
    status    : 1
    name : ''
    description:''

  $scope.form = {
    data    : [
      {
        title: 'Basic Info'
        col  : '12'
        icon : 'fa fa-inbox'
        class: 'box-info'
        form : [
          title   : 'ID'
          key     : 'id'
          type    : 'text'
          readonly: true
          required: false
        ,
          title   : 'Name'
          key     : 'name'
          type    : 'text'
          required: true
        ,
          title   : 'Description'
          key     : 'description'
          type    : 'text'
          required: true
        ]
      }
    ]
  }
  
  $scope.submit = ()->
    $scope.item.permissionList = $scope.dataPermission
    $scope.item.permissionList = _.uniq($scope.item.permissionList)
    console.log $scope.item
    ApiAdminService.group[action] $scope.item,(error, result)->
      return if error or !result
      if action is 'create'
        UtitService.notifySuccess 'Created successfull'
        return $state.go 'admin.group.update', {id: result.id}
      UtitService.notifySuccess 'Updated successfull'

  if action in ['update']
    ApiAdminService.group.get({id: $stateParams.id},(error, result)->
      return if error or !result
      $scope.item = result
      console.log '$scope.item=', $scope.item
    )

ctrl.$inject = ['UtitService', '$scope', '$rootScope', '$http', '$stateParams', '$state','ApiAdminService']

angular.module 'sbd-admin'
  .config route
  .controller "admin.controller.group.action", ctrl
