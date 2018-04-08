urlLinkApi = sails.config.connections.urlLinkApi
lodash = require('lodash')

###
@api {post} /analytic/user-community/geo-table geo-report-table
@apiName geo-report-table
@apiGroup Analytic-User-Community
@apiPermission /analytic/user-community/geo-table
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {string} type_name in body of post. in ['country_name','city_name']
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
exports.geoTable = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/geo/table'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    if result and result.data and result.data[0]
      result.data = lodash.orderBy(result.data, ['total_views'],['desc'])
    res.ok(result)

###
@api {post} /analytic/user-community/geo-chart geo-report-chart
@apiName geo-report-chart
@apiGroup Analytic-User-Community
@apiPermission /analytic/user-community/geo-chart
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {string} type_name in body of post. in ['country_name','city_name']
@apiParam {order_by_field} type_name in body of post. in ['total_views','total_duration']
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
exports.geoChart = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/geo/chart'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    if result and result.data and result.data[0]
      result.data = lodash.orderBy(result.data, ['total_views'],['desc'])
    res.ok(result)