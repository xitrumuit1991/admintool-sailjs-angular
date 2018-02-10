objectService =
  prepare : (data = {message : '', status : '',detail:''})->
    err = new Error()
    err.detail = data.detail
    err.message = data.message
    err.status = data.status
    if data.status isnt 500
      sails.log.warn err
    return err
  common:
    apiError : (error)->
      return objectService.prepare
        message : 'Hệ thống có lỗi! Vui lòng thử lại sau'
        status : 500
        detail : error

  auth :
    notFound : ()->
      objectService.prepare
        message : 'Tài khoản không tồn tại!'
        status : 404
    badRequest : ()->
      objectService.prepare
        message : 'Tài khoản không tồn tại!'
        status : 401
    invalidPassword : ()->
      objectService.prepare
        message : 'Mật khẩu không đúng'
        status : 400
    accountBlock : ()->
      objectService.prepare
        message : 'Tài khoản bị khóa'
        status : 403
module.exports = objectService