_config = ($stateProvider) ->
  $stateProvider.state "admin.group",
    url       : "/group"
    templateUrl  : '/template/admin/controller/group/view.html'
    controller: "admin.controller.group"

_config.$inject = [ "$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, UtitService, $state, GlobalConfig, ApiAdminService)->
  $scope.tableOptions =
    api              : ApiAdminService.group.list
    tableTitle : 'Group'
    tableClass : 'box-info'
    tableIcon : 'fa fa-users'
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
      title: 'Description'
      key  : 'description'
      type : 'text'
      class : 'col-limit-length-300'
#    ,
#      title: 'Status'
#      key  : 'status'
#      type : 'status'
    ]
    searchBy         : ''
    add              : 'admin.group.create'
    duplicateBySelect: null
    deleteBySelect   : null
    delete           : (item, cb)->
      console.log 'delete item', item
      return unless  confirm('Are you want to delete?')
      ApiAdminService.group.delete {id: item.id},(error, result)->
        console.log 'ApiAdminService.group.delete',result
        if error or !result
          return cb(error, null)
        cb(error, item)
    edit             : (item)->
      $state.go 'admin.group.update', {id: item.id}, {reload: true}

  ApiAdminService.group.list {page:1, limit:1000},(err, result)->
    if result and result.items
      window.sessionStorage['permission-group'] = JSON.stringify result.items

_controller.$inject = ['$rootScope', '$scope', 'UtitService', '$state', 'GlobalConfig','ApiAdminService']
angular.module "sbd-admin"
  .config _config
  .run _run
  .controller 'admin.controller.group', _controller
