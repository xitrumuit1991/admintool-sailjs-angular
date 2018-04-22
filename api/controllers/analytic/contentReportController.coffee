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
    if result and result.data and result.data[0]
      result.data = lodash.orderBy(result.data, ['total_content_views'],['desc'])
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

###
@api {post} /analytic/content-report/get-content-by-ids get-content-by-ids
@apiName get-content-by-ids
@apiGroup Analytic-Content-Report
@apiPermission /analytic/content-report/get-content-by-ids
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {string} content_ids in body of post. Ex: [ "2c826cc5-e813-4950-a8c5-44c0122ff71b", "966dba5c-c01d-402f-b96f-6694c7c72e2b"]
###
module.exports.getContentByIds = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/content/info'
    method : 'POST'
    json : true
    body : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)






#------------------content drop-off---------------------
###
@api {post} /analytic/content-report/drop-off-table drop-off table
@apiName drop-off table
@apiGroup Analytic-Content-Report
@apiPermission /analytic/content-report/drop-off-table
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
exports.dropOffTable = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/dropoff/table'
    method : 'POST'
    json : true
    body : param #form : param #data : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    if result and result.data and result.data[0]
      result.data = lodash.orderBy(result.data, ['total_play'],['desc'])
    res.ok(result)

###
@api {post} /analytic/content-report/drop-off-summary drop-off summary
@apiName drop-off summary
@apiGroup Analytic-Content-Report
@apiPermission /analytic/content-report/drop-off-summary
@apiParam {string} partner_code in body of post. Ex: 'thvli'
@apiParam {int} start in body of post. Ex: 1519862400
@apiParam {int} end in body of post. Ex: 1522540799
###
exports.dropOffSummary = (req, res)->
  param = req.allParams()
  options =
    url: urlLinkApi + '/report/dropoff/summary'
    method : 'POST'
    json : true
    body : param #form : param #data : param
  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    if result and result.data and result.data[0]
      result.data = lodash.orderBy(result.data, ['total_play'],['desc'])
    res.ok(result)

