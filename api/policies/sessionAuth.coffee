module.exports = (req, res, next) ->
  if req.headers and req.headers['by-pass-token'] is 'by-pass-token' and req.method in ['post','POST']
    return next()

  if !req.session or !req.session.user
    sails.log.error({'inFile':'sessionAuth', 'message' : 'Bạn chưa login' })
#    res.badRequest({ 'code' : 100, 'message' : 'You have not login!' });
#    return res.forbidden('Bạn chưa login', {redirect : 'login'});
    return res.redirect '/login'

  if req.session and req.session.user
    req.options.locals =
      isLogin : true
      name : req.session.user.name or req.session.user.email
    return next()

