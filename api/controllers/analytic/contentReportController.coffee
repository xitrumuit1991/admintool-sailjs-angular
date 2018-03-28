urlLinkApi = sails.config.connections.urlLinkApi
_request = require('request')


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
    url: urlLinkApi + 'report/top_content/table'
    method : 'POST'
    json : true
    form : param

  ApiService.request options,(err, result)->
    if err or !result
      return res.badRequest(err)
    res.ok(result)



module.exports.topContentChart = (req, res)->

