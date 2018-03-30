urlLinkApi = sails.config.connections.urlLinkApi

###
@api {post} /analytic/content-report/top-content-table topContentTable
@apiName topContentTable
@apiGroup Analytic-Content-Report
@apiPermission /analytic/content-report/top-content-table
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
exports.topContentTable = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/top_content/table'
    method : 'POST'
    json : true
    body : param #form : param #data : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)


###
@api {post} /analytic/content-report/top-content-chart topContentChart
@apiName topContentChart
@apiGroup Analytic-Content-Report
@apiPermission /analytic/content-report/top-content-chart
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
module.exports.topContentChart = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/top_content/chart'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)




###
@api {post} /analytic/content-report/top-content-summary topContentSummary
@apiName topContentSummary
@apiGroup Analytic-Content-Report
@apiPermission /analytic/content-report/top-content-summary
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
module.exports.topContentSummary = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/top_content/summary'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)

