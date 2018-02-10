module.exports =
  connection : 'sqlServer'
  tableName : 'group'
  autoPK : false
  schema : true
  attributes :
    id :
      type : "string"
      primaryKey : true
      defaultsTo : -> uuid.v4()
      unique : true
      index : true
    name :
      type : "string"
      unique : true
      index : true
      required : true
    description : "string"
    permissionList : "array"
    status :
      type : "integer"
      defaultsTo : 1
    createdBy : "string"
    updatedBy : "string"

  initGroupAdminData : ()->
    dataGroups =[
      name : 'admin'
      description : 'admin group'
      status : 1
    ]
    _.map dataGroups,(data)->
      group.findOneByName(data.name).exec (error, groupFinded)->
        if error
          return sails.log.error error
        return if groupFinded
        group.create(data).exec (error, groupCreated)->
          if error
            return sails.log.error error

  getActionList : (list = [], callback)->
    group.find().where({id : list}).exec (error, resGroup)->
      if error
        sails.log.error '[Error]: getListGroupQueryById', error
        return callback(error, null)
      userPermission = []
      _.map resGroup, (oneGroup)->
        _.map oneGroup.permissionList,(permis)->
          userPermission.push(permis)
      userPermission = _.uniq(userPermission)
      _.map userPermission, (item)->
        item = item.toLowerCase() if item
      callback null, userPermission

  getList : (params, callback)->
    condition = HelpService.getQuery params
    async.waterfall [
      (callback)->
        async.parallel(
          totalItems : (cb)->
            group.count().exec (error, count)->
              return cb(null, 0) if error
              cb null, count
          items : (cb)->
            group.find(condition.query)
            .paginate(condition.pagination)
            .sort(condition.sort)
            .exec (error, result)->
              return cb(error, null) if error
              cb null, result
        ,(status, result)->
          callback null, result
        )
    ], (errorCode, result)->
      callback errorCode, result

