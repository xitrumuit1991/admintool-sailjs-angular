module.exports = (req, res, next) ->
  pathname = "#{req.options.controller}/#{req.options.action}"
  pathname = "/#{pathname.toLowerCase()}" if pathname
#  sails.log.error 'pathname',pathname

  if !req.session or !req.session.user
    res.badRequest({
      'code' : 100,
      'message' : 'You have not login!',
      'pathname' : pathname
      'type' : 'TOKEN_EXPIED'
    })
    return

  #is Admin
  if req.session and req.session.user and req.session.user.isAdmin
    return next()

  listPermissionAlwayAllow = [
    '/admin/user/userprofile'
    '/admin/user/userpermission'
    '/admin/page/home'
  ]
  if req.session and req.session.user and pathname in listPermissionAlwayAllow
    return next()

  if req.session and req.session.user and !(pathname in req.session.user.permission)
    res.forbidden({
      code : 101,
      message : "You have not permission for request '#{pathname}'",
      user : if req.session and req.session.user then (req.session.user.email or req.session.user.name ) else ''
      pathname : pathname
    })
    return
  return next()


