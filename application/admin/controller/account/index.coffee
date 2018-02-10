_config = ($stateProvider) ->
  $stateProvider.state "admin.account",
    url       : "/account"
    templateUrl  : '/template/admin/controller/account/view.html'
    controller: "admin.controller.account"

_config.$inject = [
  "$stateProvider"
]
_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($rootScope, $scope, UtitService, $state, GlobalConfig, UserService, ApiAdminService)->
  $scope.userPermission = []
  $rootScope.$watch 'user',(data)->
    return unless data
    $scope.item = data

  $scope.submit = ()->
    return UtitService.notifyError('Fill all data') if !$scope.item.name or !$scope.item.email
    ApiAdminService.user.updateMyAccount $scope.item,(error, resultUser)->
#      console.log 'updateMyAccount resultUser=',resultUser
      return if error or !resultUser
      $scope.item = _.extend($scope.item,resultUser)
#      console.log 'updateMyAccount $scope.item=',$scope.item
      UserService.saveProfile($scope.item)
      UtitService.notifySuccess('Update success')

  $scope.form = {
    data    : [
      {
        title: 'My Account'
        col  : '6'
        icon : 'fa fa-inbox'
        class:'box-info'
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
          title: 'Is Admin'
          key  : 'isAdmin'
          type : 'checkbox'
          disabled:true
          readonly: true
        ]
      }
    ]
  }

  ApiAdminService.user.userpermission {},(error, result)->
    return if error or !result
    $scope.userPermission = result


#  doneUpdate = (error, result)->
#    return if error
#    UtitService.notify('Upload info success')
#    $scope.getUserProfile()
#
#  updateData = ()->
#    if $scope.user.password is ''
#      delete $scope.user.password
#    if $scope.user.password?.length < 8
#      UtitService.notify('Password at least 8,Please Try again!', 'warning')
#      return
#    $scope.user.groupId = [] if $scope.user.groupId is null
#    ApiAdminService.myAccount.update(doneUpdate, $scope.user)
#
#  $scope.getUserProfile = ()->
#    ApiAdminService.myAccount.get((error, result)->
#      return if error
#      $scope.user = result.item
#      $scope.user.dob = moment($scope.user.dob, 'YYYY-MM-DD').format("DD/MM/YYYY")
#      UserService.saveProfile(result.item)
#      $scope.user.groupValue = _.map(_.map($scope.user.group, 'groupDetail'), 'name').toString()
#  #    groupDetail = (_.pluck $scope.user.group, 'groupDetail')
#  #    $scope.user.groupValue = (_.pluck groupDetail, 'name').toString()
#    , {})
#
#  $scope.getUserProfile()

_controller.$inject = ['$rootScope', '$scope', 'UtitService', '$state', 'GlobalConfig', 'UserService', 'ApiAdminService']
angular.module "sbd-admin"
  .config _config
  .run _run
  .controller 'admin.controller.account', _controller
