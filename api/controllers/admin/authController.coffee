module.exports.login = (req, res)->
  if !req.session
    res.view('application/login', {result : {message:'Session not init, redis not connect' }})
    return
  res.view 'application/login'

module.exports.logout = (req, res)->
  if req.session
    req.session.authenticated = null
    req.session.user = null
    delete req.session.authenticated
    delete req.session.user
  sails.log.info 'logout success', req.session.user if req.session
  return res.redirect '/login'

module.exports.auth = (req, res)->
  params = req.allParams()
  return res.redirect '/login' if params and !params.submit
  if !req.session
    res.view('application/login', {result : {message:'Session not init, redis not connect' }})
    return
  if _.isEmpty(params.email) or _.isEmpty(params.password)
    res.view('application/login', {result : {message:'Missing email or password'} })
    return

  getPermissionList = (userData, cb)->
    if _.isEmpty(userData.belongGroup)
      userData.permission = []
      return cb(null, userData)
    group.getActionList userData.belongGroup, (error, result)->
      return cb(error, result) if error
      userData.permission = result
      cb(null, userData)
      return

  checkUserExist = (cb)->
    user.checkUserExit params.email, cb

  verifyPassword = (userInfo, cb)->
    if userInfo.password isnt md5(params.password)
      return cb(true, {code: 1, message : 'Password incorrect'})
    if userInfo.status != 1
      return cb(true, {code: 1, message : 'Account block'})
    cb null, userInfo

  async.waterfall [
    checkUserExist,
    verifyPassword,
    getPermissionList
  ], (error, result)->
    if error
      sails.log.error 'finishLogin ERROR',error
      req.session.authenticated = null
      req.session.user = null
      res.view('application/login', {result : result})
      return
    req.session.authenticated = true
    req.session.user = result
    sails.log.info 'req.session.authenticated',req.session.authenticated
    sails.log.info 'req.session.user',req.session.user
    res.redirect '/'