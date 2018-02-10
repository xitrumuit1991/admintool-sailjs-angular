_service = ($rootScope, $http, GlobalConfig, ApiService)->
  self = @
  self.permissionList = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/apidoc/api_data.json"
      method: 'GET'
      data  : params
    ApiService.request options, done

  self.group = {}
  self.group.list = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/group/find"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.group.delete = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/group/delete"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.group.create = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/group/create"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.group.update = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/group/update"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.group.get = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/group/findone"
      method: 'GET'
      data  : params
    ApiService.request options, done

  self.user = {}
  self.user.list = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/user/find"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.user.get = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/user/findone"
      method: 'GET'
      data  : params
    ApiService.request options, done

  self.user.create = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/user/create"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.user.update = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/user/update"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.user.updateMyAccount = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/user/updatemyaccount"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.user.delete = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/user/delete"
      method: 'POST'
      data  : params
    ApiService.request options, done

  self.user.userpermission = (params, done)->
    options =
      url   : "#{GlobalConfig.apiUrl}/admin/user/userpermission"
      method: 'GET'
      data  : params
    ApiService.request options, done

  return
_service.$inject = ['$rootScope', '$http', 'GlobalConfig', 'ApiService']
angular
  .module('sbd-admin')
  .service('ApiAdminService', _service);

