config =
  version : '1.0.0'
  uuid : (new Fingerprint({canvas : true, screen_resolution : false})).get()
  modelName : navigator.userAgent
  platform : 'admintool'
  env : window.ENV
switch window.ENV
  when 'production', 'prod'
    config = _.extend(config, {
      apiUrl : ''
    })
  when 'development', 'dev'
    config = _.extend(config, {
      apiUrl : ''
    })
  else
    config = _.extend(config, {
      apiUrl : ''
    })

angular.element(document).ready () ->
  async.parallel([
    (cb)->
      $.get('/admin/group/find?limit=1000&page=1', (result)->
        if result and result.items then window.sessionStorage['permission-group'] = JSON.stringify result.items
        cb(null, true)
      ).error (error)-> console.error(error); cb(null, true)
  , (cb)->
      $.get("/apidoc/api_data.json", (result)->
        if result then window.sessionStorage['permissions-list-action'] = JSON.stringify result
        cb(null, true)
      ).error (error)-> console.error(error); cb(null, true)
  , (cb)->
      $.get('/admin/user/userprofile', (result)->
        if result then window.localStorage['user'] = JSON.stringify result
        cb(null, true)
      ).error (error)-> console.error(error); cb(null, true)
  , (cb)->
      $.get('/admin/user/userpermission', (result)->
        if result then window.localStorage['user-permission'] = JSON.stringify result
        visiblePage = []
        _.map result, (item)->
          if item and item.match('/admin/page/') isnt null
            visiblePage.push item.replace('/admin/page/', '')
        window.sessionStorage['permission-module-page'] = JSON.stringify visiblePage
        cb(null, true)
      ).error (error)-> console.error(error); cb(null, true)
  ], (error, result)->
    console.error error if error
    console.warn 'ANGULAR APP READY'
    angular.bootstrap(document, ["sbd-admin"], strictDi : true)
  )

initInjector = angular.injector(["ng"])
$http = initInjector.get("$http")
window.app = angular.module 'sbd-admin', [
  'ui.bootstrap',
  'ui.router',
  'ui.utils',
  'ngMessageFormat',
  'angularFileUpload',
  'ngNotify',
  'cgNotify',
  'angular-uuid',
  'ngTagsInput',
  'ngSanitize',
  'nvd3',
  'angularjs-datetime-picker',
  'chart.js',
  'oc.lazyLoad',
  'googlechart',
]

angular.module('sbd-admin').constant("GlobalConfig", config)
console.warn 'GlobalConfig',config

_config = ($locationProvider, $urlRouterProvider, $stateProvider) ->
  $locationProvider.hashPrefix('')
  $urlRouterProvider.otherwise('/')
_config.$inject = ['$locationProvider', '$urlRouterProvider', '$stateProvider']

run = ($rootScope, $state, $window, $http, UtitService, ApiService)->
  if _.isEmpty(window.localStorage.user)
    timeCountdown = 5
    UtitService.notifyError("User is not login. Redirect to /login in #{timeCountdown} seconds")
    setInterval(()->
      timeCountdown--
      UtitService.notifyError("User is not login. Redirect to /login in #{timeCountdown} seconds")
      if timeCountdown <= 0 then return window.location.href = '/logout'
    ,1000)
    return

  try
    $rootScope.user = JSON.parse(window.localStorage.user)
    $rootScope.user.avatar = "img/avatar#{_.random(1,5)}.png" if _.isEmpty($rootScope.user.avatar)
  catch e

  $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
    $rootScope.breadcrumb = []
    stateTemp = toState.name.split('.')
    href = ''
    _.map stateTemp, (item)->
      href = "#{href}#{item}."
      $rootScope.breadcrumb.push({
        href : href.replace(/.$/, '')
        title : item
        name : item
      })

  $rootScope.btnClass = UtitService.btnClass
  $rootScope.bg = UtitService.bgClass

  menuDashboard = [
    slug : 'admin'
    title : 'Admin'
    href : '/admin'
    icon : 'fa fa-user'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ,
    slug : 'analytic'
    title : 'Analytic'
    href : '/analytic'
    icon : 'fa fa-pie-chart'
    bg : $rootScope.bg[_.random(0, $rootScope.bg.length - 1)]
  ]

  $rootScope.topSidebar = []
  if $rootScope.user and $rootScope.user.isAdmin
    $rootScope.topSidebar = menuDashboard
  else
    pageVisiable = JSON.parse window.sessionStorage['permission-module-page']
    _.map pageVisiable, (item)->
      page = _.find(menuDashboard, {slug : item})
      return unless page
      $rootScope.topSidebar.push page

run.$inject = ['$rootScope', '$state', '$window', '$http', 'UtitService', 'ApiService']
angular.module("sbd-admin").config _config
  .run run
