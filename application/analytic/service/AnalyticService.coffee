_service = ($rootScope, $http, GlobalConfig, UtitService, uuid, ApiService)->
  self = @
  self.contentReport =
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

