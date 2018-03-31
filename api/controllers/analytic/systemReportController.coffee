urlLinkApi = sails.config.connections.urlLinkApi
lodash = require('lodash')

###
@api {post} /analytic/system-report/platform-table platform-table
@apiName platform-table
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/platform-table
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
exports.platformTable = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/platform/table'
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
@api {post} /analytic/system-report/platform-chart platform-chart
@apiName platform-chart
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/platform-chart
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
module.exports.platformChart = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/platform/chart'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)




###
@api {post} /analytic/system-report/platform-summary platform-summary
@apiName platform-summary
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/platform-summary
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
module.exports.platformSummary = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/platform/summary'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)








###
@api {post} /analytic/system-report/os-table os-table
@apiName os-table
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/os-table
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
exports.osTable = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/os/table'
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
@api {post} /analytic/system-report/os-chart os-chart
@apiName os-chart
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/os-chart
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
module.exports.osChart = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/os/chart'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)

###
@api {post} /analytic/system-report/os-summary os-summary
@apiName os-summary
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/os-summary
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
module.exports.osSummary = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/os/summary'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)












###
@api {post} /analytic/system-report/browser-table browser-table
@apiName browser-table
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/browser-table
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
exports.browserTable = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/browser/table'
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
@api {post} /analytic/system-report/browser-chart browser-chart
@apiName browser-chart
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/browser-chart
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
module.exports.browserChart = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/browser/chart'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)

###
@api {post} /analytic/system-report/browser-summary browser-summary
@apiName browser-summary
@apiGroup Analytic-System-Report
@apiPermission /analytic/system-report/browser-summary
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
module.exports.browserSummary = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/browser/summary'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)