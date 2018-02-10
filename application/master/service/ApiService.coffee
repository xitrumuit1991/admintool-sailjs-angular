_service = ($rootScope, $http, GlobalConfig, UtitService, UserService)->
  self = @
  self.commonData = {}
  self.listPermissionAlwayAllow = [
    '/admin/user/userprofile'
    '/admin/user/userpermission'
    '/admin/page/home'
  ]

  self.havePermissionFrontEnd = (url)->
    if url
      url = url.toLowerCase()
      url = url.replace(GlobalConfig.apiUrl,'')
#    console.log 'url', url
    userpermission = []
    return true if $rootScope.user and $rootScope.user.isAdmin
    return true if url in self.listPermissionAlwayAllow
    return false if _.isEmpty(window.localStorage['user-permission'])
    try
      userpermission = JSON.parse window.localStorage['user-permission']
    catch e
#    console.log 'userpermission', userpermission
    if url in userpermission
      return true
    return false

  self.request = (options, done)->
    return UtitService.notifyError('You are not permission!') if !self.havePermissionFrontEnd(options.url)
    options.data = _.extend(_.clone(self.commonData), options.data)
    if options.method and options.method.toUpperCase() is 'GET' and options.data
      options.url = "#{options.url}?#{$.param(options.data)}"
      delete options.data
    options.headers = {} if _.isEmpty(options.headers)
    options.headers['Content-Type'] =  'application/json'
    options.headers.Authorization = localStorage.token if localStorage.token
    $http(options).then(((res)->
      done(null, res.data)
    ),(error)->
      console.error 'ApiService error='
      console.error error
      message = error?.data?.message || 'Unknow Error'
      if error.status is 403 and error.data.code is 101 #not permission
        UtitService.notifyError(message)
      else if !options.hideNotifyError
        UtitService.notifyError(message)
      if error.status is 400 and error.data.code is 100 and error.data.type is "TOKEN_EXPIED"
        UserService.logout()
      done(error.data, null)
    )

  return null
_service.$inject = ['$rootScope', '$http', 'GlobalConfig', 'UtitService','UserService']
angular
  .module('sbd-admin')
  .service('ApiService', _service);

