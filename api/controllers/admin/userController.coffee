module.exports.userprofile = (req, res)->
  if req.session and req.session.user
    user = _.clone(req.session.user)
    delete  user.password
    return res.ok user
  return res.ok {}

module.exports.userpermission = (req, res)->
  if req.session and req.session.user
    user = _.clone(req.session.user)
    if user and user.permission
      return res.ok user.permission
  return res.ok []

###
@api {get} /admin/user/find Get users
@apiName Get Users info
@apiGroup Admin-User
@apiPermission /admin/user/find
###
module.exports.find = (req, res)->
  params = req.allParams()
  user.getList params, (error, result)->
    if error
      return res.badRequest({code:1, detail: error, message: error})
    res.ok result

###
@api {get} /admin/user/findone Get a user
@apiName Get A user info
@apiGroup Admin-User
@apiPermission /admin/user/findone
@apiParam {string} id in query
###
module.exports.findOne = (req, res)->
  data = req.allParams()
  if !data.id
    return res.badRequest({code:1, message: 'miss id'})
  user.findOneById(data.id).exec (error, result) ->
    if error
      return res.badRequest({code:1, message: 'not found user'})
    delete result.password
    res.ok result

###
@api {post} /admin/user/create Create user
@apiName Post Create user
@apiGroup Admin-User
@apiPermission /admin/user/create
@apiParam {object} data in body of post
###
module.exports.create = (req, res)->
  params = req.allParams()
  unless params.email?
    return res.badRequest({code:1, message: 'Please input email'})
  unless params.password?
    return res.badRequest({code:1, message: 'Please input password'})
  params.createdBy = if req.session and req.session.user then req.session.user.email else ''
  user.create params, (error, result)->
    if error
      return res.badRequest({code:1, detail: error, message: error})
    res.ok result

###
@api {put} /admin/user/update Update user
@apiName Put Update user
@apiGroup Admin-User
@apiPermission /admin/user/update
@apiParam {string} id in query
@apiParam {object} data in body of put
###
module.exports.update = (req, res)->
  data = req.allParams()
  if !data.id
    return res.badRequest({code:1, message: 'Missing id'})
  user.update({id : data.id}, data).exec (error, result)->
    if error
      return res.badRequest({code:1, detail: error, message: error})
    res.ok result


###
@api {post} /admin/user/updatemyaccount Update My Account
@apiName Update My Account
@apiGroup Admin-User
@apiPermission /admin/user/updatemyaccount
@apiParam {string} id in query
@apiParam {object} data in body of put
###
module.exports.updatemyaccount = (req, res)->
  params = req.allParams()
  return res.badRequest({code:1, message: 'miss id'}) if !params.id
  user.updateMyAccount params, (error, results)->
    if error
      res.badRequest({code:1, detail: error, message: error})
      return
    if req.session and req.session.user
      if results and results[0] and results[0].id == req.session.user.id
        userOld = _.clone(req.session.user)
        results[0].permission = userOld.permission
        req.session.user = results[0]
    dataRes = (req.session.user or results[0])
    delete dataRes.password
    res.ok dataRes



###
@api {delete} /admin/user/delete Delete User
@apiName Delete One User
@apiGroup Admin-User
@apiPermission /admin/user/delete
@apiParam {string} id in query
###
exports.delete = (req, res)->
  data = req.allParams()
  if !data.id
    res.badRequest({code : 1, message : "Missing id"})
    return
  user.destroy({id : data.id}).exec (error, result)->
    if error
      return res.badRequest({code:1, detail: error, message: error})
    res.ok result