_service = ($rootScope, $http, GlobalConfig, UtitService, uuid, ApiService)->
  self = @
  self.analytic =
    concurrent : (done, params = {})->
      options =
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/dashboard/count-current-user"
        method : "GET"
        data : params
      ApiService.request(options, done)

    totalSummary : (done, params = {})->
      options =
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/dashboard/total-summary"
        method : "GET"
        data : params
      ApiService.request(options, done)
    top10Country : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/asset/country"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/dashboard/top10-country-view"
        method : "GET"
        data : params
      ApiService.request(options, done)

    trendingPastHour : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/asset/trend"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/dashboard/trending"
        method : "GET"
        data : params
      ApiService.request(options, done)

    popularNow : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/asset/popular"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/dashboard/popular"
        method : "GET"
        data : params
      ApiService.request(options, done)

    topContent : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/asset/content"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/dashboard/top-content"
        method : "GET"
        data : params
      ApiService.request(options, done)

    topContentLine : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/asset/line"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/dashboard/top-content-line"
        method : "GET"
        data : params
      ApiService.request(options, done)

  self.analytic.business =
    geography : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/perform/geo"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/geo"
        method : "GET"
        data : params
      ApiService.request(options, done)

    device : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/perform/device"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/device"
        method : "GET"
        data : params
      ApiService.request(options, done)

    player : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/perform/player"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/player"
        method : "GET"
        data : params
      ApiService.request(options, done)

    traffic : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/perform/traffic"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/traffic"
        method : "GET"
        data : params
      ApiService.request(options, done)

    assetVideo : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/perform/asset"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/asset-video"
        method : "GET"
        data : params
      ApiService.request(options, done)

    performanceTotal : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/perform/total"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/performance-total"
        method : "GET"
        data : params
      ApiService.request(options, done)

    performanceLine : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/perform/line"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/performance-line"
        method : "GET"
        data : params
      ApiService.request(options, done)

    throughTotal : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/through/total"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/play-through-total"
        method : "GET"
        data : params
      ApiService.request(options, done)

    throughLine : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/through/line"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/play-through-line"
        method : "GET"
        data : params
      ApiService.request(options, done)

    reachTotal : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/reach/total"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/reach-total"
        method : "GET"
        data : params
      ApiService.request(options, done)

    reachLine : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/reach/line"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/reach-line"
        method : "GET"
        data : params
      ApiService.request(options, done)

    engamentTotal : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/engament/total"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/engament-total"
        method : "GET"
        data : params
      ApiService.request(options, done)

    engamentLine : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/engament/line"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/business/engament-line"
        method : "GET"
        data : params
      ApiService.request(options, done)

  self.analytic.video =
    video30View : (done, params = {})->
      options =
        url   : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/video-30-view"
        method: "GET"
        data  : params
      ApiService.request(options, done)
    summary : (done, params = {})->
      options =
        url   : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/summary"
        method: "GET"
        data  : params
      ApiService.request(options, done)

    info : (done, params = {})->
      options =
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/info"
        method : "GET"
        data : params
      ApiService.request(options, done)

    uniqueUser : (done, params = {})->
      #play_rq, unique_user, hours_watched, play_through.
      #url   : "/v1/video/detail_list"
      options =
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/unique-user"
        method : "GET"
        data : params
      ApiService.request(options, done)

    segments_watched : (done, params = {})->
      options =
#        url   : "#{GlobalConfig.apiUrl}/analytics/video/segments_watched"
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/segment-watched"
        method : "GET"
        data : params
      ApiService.request(options, done)

    typePlayerTrafficGeoDeviceTable : (done, params = {})->
      options =
        url   : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/metric-list/#{params.type}"
        method: "GET"
        data  : params
      ApiService.request(options, done)

    device : (done, params = {})->
      options =
        url   : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/metric/device"
        method: "GET"
        data  : params
      ApiService.request(options, done)

    geo : (done, params = {})->
      options =
        url   : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/metric/geo"
        method: "GET"
        data  : params
      ApiService.request(options, done)

    player : (done, params = {})->
      options =
        url   : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/metric/player"
        method: "GET"
        data  : params
      ApiService.request(options, done)

    traffic : (done, params = {})->
      options =
        url   : "#{GlobalConfig.apiUrl}/private/v1/analytic/entity/#{params.entity_id}/metric/traffic"
        method: "GET"
        data  : params
      ApiService.request(options, done)

  self.analytic.forward =
    metricMux : (done, params = {})->
      options =
        url : "#{GlobalConfig.apiUrl}/private/v1/analytic/forward/metricMux"
        method : "GET"
        data : params
      ApiService.request(options, done)
  return
_service.$inject = ['$rootScope', '$http', 'GlobalConfig', 'UtitService', 'uuid', 'ApiService']
angular.module('sbd-admin')
  .service('AnalyticService', _service);

