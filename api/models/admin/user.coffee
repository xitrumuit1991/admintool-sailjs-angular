module.exports =
  connection : 'sqlServer'
  tableName : 'user'
  autoPK : false
  schema : true
  attributes :
    id :
      type : "string"
      primaryKey : true
      defaultsTo : ()-> return uuid.v4()
      unique : true
      index : true
    isAdmin :
      type : 'integer'
      defaultsTo : 0
    name : "string"
    phone : "string"
    password :
      type : "string"
      required : true
    email :
      type : "email"
      unique : true
      index : true
      required : true
    avatar : 'text'
    belongGroup : "array"
    status :
      type : "integer"
      defaultsTo : 1
    createdBy : "string"
    updatedBy : "string"
    partner_code : 'string'

  initUserAdminData : ()->
    dataUsers =[
      name : 'admin'
      email : 'admin@gmail.com'
      password : 'admin123!@#'
      isAdmin : 1
    ,
      name : 'nguyentvk'
      email : 'nguyentvk@mail.com'
      password : 'nguyentvk123!@#'
      isAdmin : 1
      partner_code : 'thvli'
    ,
      name : 'superadmin'
      email : 'superadmin@mail.com'
      password : 'superadmin123!@#'
      isAdmin : 1
    ,
      name : 'duybq'
      email : 'duybq@mail.com'
      password : 'duybq123!@#'
      isAdmin : 1
    ,
      name : 'thvli'
      email : 'thvli@mail.com'
      password : 'thvli123!@#'
      isAdmin : 1
      partner_code : 'thvli'
    ]
    _.map dataUsers,(data)->
      user.findOneByEmail(data.email).exec (error, userData)->
        if error
          return sails.log.error error
        return if userData
        user.create(data).exec (error, userCreated)->
          if error
            return sails.log.error error
          console.log 'initUserAdminData; userCreated=',userCreated

  beforeCreate : (values, cb) ->
    if values.password then values.password = md5(values.password)
    cb()

  beforeUpdate : (values, cb) ->
    if values.password then values.password = md5(values.password)
    cb()

  checkUserExit : (email, cb)->
    user.findOneByEmail(email).exec (error, result)->
      if error
        return cb true, {code: 1, message:'Server error'}
      if _.isEmpty(result)
        return cb true, {code:1, message:'Account is not found'}
      return cb null, result

  updateMyAccount : (params, callback)->
    user.update({id : params.id}, params).exec (error, users) ->
      if error
        callback {code:1, message:'Server error' }, {code:1, message:'Server error' }
        return
      callback null, users

  getList : (params, callback)->
    condition = HelpService.getQuery params
    async.waterfall [
      (callback)->
        async.parallel(
          totalItems : (cb)->
            user.count().where(isAdmin : false).exec (error, count)->
              if error
                return cb null, 0
              cb null, count
          items : (cb)->
            user.find(condition.query)
            .where(isAdmin : false)
            .paginate(condition.pagination)
            .sort(condition.sort)
            .exec (error, result)->
              if error
                return cb error, null
              cb null, result
        ,
          (status, result)->
            callback null, result
        )
    ], (errorCode, resultCode)->
      callback(errorCode, resultCode)

#  module.exports.profile = (req, res)->
#    if req.session.authenticated != true or HelpService.isEmpty(req.session.user) is true
#      result =
#        message : 'Invalid request. Not login'
#      return res.view('pages/profile', {result : result})
#
#    userId = req.session.user.id
#    if HelpService.isEmpty(req.body) is true
#      User.findOne({id : userId}).exec (error, user)->
#        if error or user is undefined or user is null
#          result =
#            message : 'Not found user id=' + userId
#          return res.view('pages/profile', {result : result})
#        return res.view('pages/profile', {user : user})
#    else
#      userPost = req.body
#      sails.log.info 'userPost=', userPost
#      User.update({id : userId}, userPost).exec (error, userUpdated) ->
#        if error or userUpdated is undefined or userUpdated is null
#          result =
#            message : 'Update user không thành công'
#          return res.view('pages/profile', {result : result})
#
#        sails.log.info '[Success] userUpdated=', userUpdated[0]
#        return res.view('pages/profile', {user : userUpdated[0], result : {message : "update thành công"}})