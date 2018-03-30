urlLinkApi = sails.config.connections.urlLinkApi

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

