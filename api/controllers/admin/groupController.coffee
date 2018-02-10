done = (res, error, result)->
  if error
    return res.badRequest({code:1 , detail : error, message : 'Error'})
  res.ok result
###
@api {get} /admin/group/find Get groups
@apiName Get Groups info
@apiGroup Admin-Group
@apiPermission /admin/group/find
###
exports.find = (req, res)->
  params = req.query
  group.getList params, done.bind(@, res)

###
@api {get} /admin/group/findone Get a group
@apiName Get A group info
@apiGroup Admin-Group
@apiPermission /admin/group/findone
@apiParam {string} [id] in query
###
exports.findOne = (req, res)->
  param = req.allParams()
  if _.isEmpty(param.id)
    res.badRequest({code:1, message : "invalid request, missing id"})
    return
  group.findOneById(param.id).exec done.bind(@, res)

###
@api {post} /admin/group/create Create group
@apiName Post Create group
@apiGroup Admin-Group
@apiPermission /admin/group/create
@apiParam {object} data in body of post
###
exports.create = (req, res)->
  data = req.allParams()
  if typeof data.name == 'undefined' or data.name == null
    return res.badRequest({code : 1, message : 'Vui lòng nhập tên group'})
  data.createdBy = if req.session and req.session.user then req.session.user.id else 'unknown'
  group.create data, done.bind(@, res)

###
@api {put} /admin/group/update Update group
@apiName Put Update group
@apiGroup Admin-Group
@apiPermission /admin/group/update
@apiParam {string} [id] in query
@apiParam {object} data in body of put
###
exports.update = (req, res)->
  data = req.allParams()
  if data.id is undefined
    res.badRequest({code : 1, message : "Missing id"})
    return
  data.updatedBy = if req.session and req.session.user then req.session.user.id else 'Unknown'
  group.update({id : data.id}, data).exec done.bind(@, res)

###
@api {delete} /admin/group/delete Delete group
@apiName Delete One group
@apiGroup Admin-Group
@apiPermission /admin/group/delete
@apiParam {string} [id] in query
###
exports.delete = (req, res)->
  data = req.allParams()
  if !data.id
    res.badRequest({code : 1, message : "Missing id"})
    return
  group.destroy({id : data.id}).exec done.bind(@, res)