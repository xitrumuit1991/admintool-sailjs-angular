_service = ($rootScope, $http, GlobalConfig, UtitService, uuid, ApiService)->
  self = @
  self.userCommunityReport =
    geoTable :(params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/user-community/geo-table"
        method : "POST"
        data : params
      ApiService.request(options, done)
    geoChart :(params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/user-community/geo-chart"
        method : "POST"
        data : params
      ApiService.request(options, done)

  self.systemReport =
    platformTable : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/platform-table"
        method : "POST"
        data : params
      ApiService.request(options, done)
    platformChart : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/platform-chart"
        method : "POST"
        data : params
      ApiService.request(options, done)
    platformSummary : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/platform-summary"
        method : "POST"
        data : params
      ApiService.request(options, done)
    osTable : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/os-table"
        method : "POST"
        data : params
      ApiService.request(options, done)
    osChart : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/os-chart"
        method : "POST"
        data : params
      ApiService.request(options, done)
    osSummary : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/os-summary"
        method : "POST"
        data : params
      ApiService.request(options, done)
    browserTable : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/browser-table"
        method : "POST"
        data : params
      ApiService.request(options, done)
    browserChart : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/browser-chart"
        method : "POST"
        data : params
      ApiService.request(options, done)
    browserSummary : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/system-report/browser-summary"
        method : "POST"
        data : params
      ApiService.request(options, done)


  self.contentReport =
    getContentByIds : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/content-report/get-content-by-ids"
        method : "POST"
        data : params
      ApiService.request(options, done)
    topContentTable : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/content-report/top-content-table"
        method : "POST"
        data : params
      ApiService.request(options, done)

    topContentChart : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/content-report/top-content-chart"
        method : "POST"
        data : params
      ApiService.request(options, done)

    topContentSummary : (params = {}, done)->
      options =
        url : "#{GlobalConfig.apiUrl}/analytic/content-report/top-content-summary"
        method : "POST"
        data : params
      ApiService.request(options, done)

  return
_service.$inject = ['$rootScope', '$http', 'GlobalConfig', 'UtitService', 'uuid', 'ApiService']
angular.module('sbd-admin')
  .service('AnalyticService', _service);

