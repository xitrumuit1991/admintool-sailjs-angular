_service = ($timeout, $rootScope, $state, notify, uuid)->
  self = @
  self.saveProfile = (user)->
    localStorage.user = JSON.stringify user
    $rootScope.user = user
  
  self.profile = ()->
    userInfo = localStorage.user
    try
      userInfo = JSON.parse userInfo
    catch e
      userInfo = {}
    return userInfo

  self.logout = ()->
    window.localStorage.clear()
    window.sessionStorage.clear()
    window.location.href = '/logout'
    return

  return null
_service.$inject = ['$timeout', '$rootScope', '$state', 'notify', 'uuid']
angular.module('sbd-admin').service('UserService', _service);


