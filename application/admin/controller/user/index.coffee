_config = ($stateProvider) ->
  $stateProvider.state "admin.user",
    url       : "/user"
    templateUrl  : '/template/admin/controller/user/view.html'
    controller: "admin.controller.user"

_config.$inject = [ "$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, UtitService, $state, GlobalConfig, ApiAdminService)->
  $scope.tableOptions =
    api              : ApiAdminService.user.list
    tableTitle : 'User Management'
    tableClass : 'box-danger'
    form             : [
      title      : ''
      key        : 'isSelect'
      type       : 'actionBox'
      disableSort: true
    ,
      title: 'Name'
      key  : 'name'
      type : 'text'
    ,
      title: 'Email'
      key  : 'email'
      type : 'text'
    ,
      title: 'Phone'
      key  : 'phone'
      type : 'text'
    ,
      title: 'Status'
      key  : 'status'
      type : 'status'
#    ,
#      title: 'Belong group'
#      key  : 'belongGroup'
#      type : 'text'
#      options : []
#    ,
#      title: 'Updated At'
#      key  : 'updatedAt'
#      type : 'date'
    ,
      title: 'Group'
      key  : 'belongGroup'
      type : 'adminGroup'
    ]
    searchBy         : ''
    add              : 'admin.user.create'
    duplicateBySelect: null
    deleteBySelect   : null
    delete           : (item, cb)->
      console.log 'delete item', item
      return unless  confirm('Are you want to delete?')
      ApiAdminService.user.delete {id: item.id},(error, result)->
        console.log 'ApiAdminService.user.delete',result
        if error or !result
          return cb(error, null)
        cb(error, item)
    edit             : (item)->
      $state.go 'admin.user.update', {id: item.id}, {reload: true}


  ApiAdminService.group.list {page:1, limit:1000},(err, result)->
    if result and result.items
      window.sessionStorage['permission-group'] = JSON.stringify result.items

_controller.$inject = ['$rootScope', '$scope', 'UtitService', '$state', 'GlobalConfig','ApiAdminService']
angular.module "sbd-admin"
  .config _config
  .run _run
  .controller 'admin.controller.user', _controller
