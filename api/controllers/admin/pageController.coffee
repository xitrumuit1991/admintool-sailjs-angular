module.exports.template = (req, res)->
  res.view '_template'

module.exports.home = (req, res)->
  if req.session and req.session.user
    return res.view 'home'
  return res.redirect '/login'

###
@api {get} /admin/page/admin Module Admin
@apiName Module Admin
@apiGroup Admin-Page
@apiPermission /admin/page/admin
###
module.exports.admin = (req, res) ->
  res.view 'application/admin'


###
@api {get} /admin/page/analytic Module Analytic
@apiName Module Analytic
@apiGroup Admin-Page
@apiPermission /admin/page/analytic
###
module.exports.analytic = (req, res)->
  res.view 'application/analytic'