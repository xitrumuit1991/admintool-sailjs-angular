fs = require('fs.extra');
module.exports =

  getIdOfSubtitleFile : (sub)->
    id = sub.split('/');
    id = id[id.length - 1].split('.')
    id = id[0]
    return id

  checkSubOfIos : (name)->
    id = name.split('_')
    if(id.length is 2)
      if(id[1] == 'abc')
        return id[0]
    return null

  prepairDataReturn : (query, pagination)->
    resData =
      query : query
      pagination : pagination
      totalItems : 0
      data : []
    return resData

  getQuery : (params)->
    query = {}
    sort = {}
    pagination = {}
    dateRange = {}
    _.map params, (value, key)->
      if key in ['sort'] and !!value
        try
          sort = _.extend sort, JSON.parse value
        catch e
          sails.log.warn e
      if key in ['limit', 'page'] and !!value
        pagination[key] = parseInt value
      if key in ['fromDate'] and !!value
        dateRange['>='] = new Date(value)

      if key in ['toDate'] and !!value
        dateRange['<='] = new Date(value)
      unless key in ['limit', 'page', 'sort', 'fromDate', 'toDate', 'export']
        return if value is ''
        query[key] =
          contains : value
    if !pagination.limit or !pagination.page
      pagination =
        limit : 30
        page : if params.fromDate and params.toDate then 9007199254740991 else 1
    data =
      pagination : pagination
      query : query
      sort : if _.isEmpty(sort) then  {updatedAt : 0} else sort
      dateRange : dateRange
    return data

  detectImageFileName : (filename)->
    regexFileName = /^(.*)\.(\w{2,4})$/i
    fileNameLower = filename.toLowerCase()
    resultRegex = regexFileName.exec fileNameLower
    if resultRegex and resultRegex[1]
      return HelpService.detectImageAvailable resultRegex[1]
    false

  detectImageAvailable : (images)->
    imageTypes = Image.imageTypes
    images = [images] unless Array.isArray images
    imagesResult = []
    for image in images
      if typeof image == 'object'
        strImage = image.imageType + '_' + (if image.aspect then image.aspect.replace ':', 'x') + '_' + image.height + 'x' + image.width
      else if typeof image == 'string'
        strImage = image
        resultRegex = /(.*)_(\d*)x(\d*)_(\d*)x(\d*)$/.exec strImage
        if resultRegex and resultRegex.length == 6
          image =
            imageType : resultRegex[1].toLowerCase()
            aspect : "#{resultRegex[2]}:#{resultRegex[3]}"
            width : resultRegex[4]
            height : resultRegex[5]
        else
          break
      else
        break
      if imageTypes[strImage]
        image.resolutionType = imageTypes[strImage]
        imagesResult.push image
    if imagesResult.length < 1
      false
    else if imagesResult.length == 1
      imagesResult[0]
    else
      imagesResult

  generateUrlPlayTrailer : (sourceId)->
    config = sails.config.connections
    "#{config.api.sourceMedia}#{md5 sourceId + '|' + config.key.hashUrl}/#{sourceId}/playlist.mpd"


  formatInputFileTranscode : (data = [])->
    path = require('path')
    output = []
    _.forEach data, (value)->
      step = value.url.split(path.sep)
      currentPath = ''
      level = 0
      _.forEach step, (item)->
        return if item is ''
        currentPath = "#{currentPath}/#{item}"
        ext = path.extname(item)
        output.push
          path : currentPath
          name : item
          type : if ext is '' then 'path' else 'file'
          ext : ext
          level : level++
          size : if ext is '' then 0 else value.size
    output = _.uniq output, (item, key, path)->
      return item.path
    return output


  uploadFile : (req, res, options, callback)->
    config = sails.config.connections
    defaultOptions =
      dest : if config.upload and config.upload.path then config.upload.path else '/upload/'
      folderStorage : ''
      serverPath : if config.upload and config.upload.server then config.upload.server else ''
      allowedTypes : ['*']
      limit : 10 * 1024 * 1024
#      filter : (file, cb)->
#        cb null, fileNameNew : id + '.' + file.ext
      storage : (file, cb)->
        pathStorage = options.dest + if options.folderStorage then options.folderStorage + '/' else ''
        unless fs.existsSync pathStorage
          fs.mkdirSync pathStorage
        cb null, pathStorage

    if options
      options = Object.assign {}, defaultOptions, options
    else
      options = defaultOptions

    firtProcess = (file, cb)->
      unless options.limit or file.size > options.limit
        return cb "File limit is #{options.limit}", file

      mime = require 'mime'
      file.type = mime.lookup file.fd if file.fd
      if (Array.isArray options.allowedTypes) and (options.allowedTypes.indexOf('*') is -1) and (options.allowedTypes.indexOf(file.type) is -1)
        return cb "Filte type don't support.", file
      fileExtension = file.filename.split '.'
      file.ext = fileExtension.pop()
      file.name = fileExtension.join ''

      cb null, file

    deleteFileError = (file)->
      if file and file.fd
        fs.unlink file.fd, (error, result)->
          sails.log.error error, null if error

    taskAsync = []
    errorMessages = []

    req.file("files").upload maxBytes : options.limit, (error, filesList)->
      callback error, null if error
      for file in filesList
        firtProcess file, (error, file)->
          if error
            deleteFileError file
            errorMessages.push error
            return
          if options.filter
            options.filter file, (error, fileInfo)->
              if error
                deleteFileError file
                return errorMessages.push error
              options.storage file, (error, pathStorage)->
                if error
                  deleteFileError file
                  return errorMessages.push error
                do ()->
                  taskAsync.push (cb)->
                    streamRead = fs.createReadStream file.fd
                    streamWrite = fs.createWriteStream pathStorage + fileInfo.fileNameNew
                    streamRead.pipe streamWrite
                    streamWrite.on 'error', (error)->
                      deleteFileError file
                      sails.log.error error
                      cb true, null
                    streamWrite.on 'close', ()->
                      fileInfo.name = file.name
                      fileInfo.originalName = file.filename
                      fileInfo.uri = "#{options.serverPath + options.folderStorage}/#{fileInfo.fileNameNew}"
                      deleteFileError file
                      cb null, fileInfo

      if taskAsync.length > 0
        async.parallel taskAsync, (error, result)->
          return callback error, null if error or result.length < 1
          callback null, result
      else
        callback errorMessages, null

  clearCache : (keyId)->
    return false unless keyId
    request = require 'request'
    sails.log "Cache key: #{keyId}vi"
    sails.log "Cache key: #{keyId}en"
    optionVi =
      url : "#{sails.config.connections.api.clearCache}clearCacheSecret?key=#{keyId}vi"
      headers :
        'api-key' : '$1a$10$wJrsziiTHN0I8.jj3vH7M.IPKr0./PQ/HxhG0FPItK3xwVv3c2H0q'
    optionEn =
      url : "#{sails.config.connections.api.clearCache}clearCacheSecret?key=#{keyId}en"
      headers :
        'api-key' : "#{sails.config.connections.key.apiCm}"
    i = 0
    while i < 2
      i++
      request optionVi, (error, response, body)->
        if error or response.statusCode != 200
          return sails.log.error error, response.statusCode, body
        sails.log "Clear cache success: #{keyId}vi"
      request optionEn, (error, response, body)->
        if error or response.statusCode != 200
          return sails.log.error error, response.statusCode, body
        sails.log "Clear cache success: #{keyId}en"

  classifyUpdateData : (listOld, listNew, listField)->
    result =
      listDelete : []
      listUpdate : []
      listCreate : []
    for aNew in listNew
      isNew = true
      for aOld in listOld
        if HelpService.compareObject aNew, aOld, listField
          isNew = false
          break
      if isNew
        result.listCreate.push aNew
      else
        result.listUpdate.push aNew
    for aOld in listOld
      isDelete = true
      for aUpdate in result.listUpdate
        if HelpService.compareObject aUpdate, aOld, listField
          isDelete = false
          break
      if isDelete
        result.listDelete.push aOld
    return result

  updateOneAndMore : (modelObject, dataUpdate, idOfOne, attrIdNameOfOne, attrIdNameOfMore, callback)->
    where = {}
    where[attrIdNameOfOne] = idOfOne
    modelObject.find(where).exec (error, dataHasInDB)->
      return callback MessageService.common.system error, null if error
      resultClassify = HelpService.classifyUpdateData dataHasInDB, dataUpdate, [attrIdNameOfMore, attrIdNameOfMore]
      async.parallel {
        delete : (cb)->
          return cb null, null if resultClassify.listDelete.length < 1
          where = {}
          where[attrIdNameOfOne] = idOfOne
          where[attrIdNameOfMore] = HelpService.getIds resultClassify.listDelete, attrIdNameOfMore
          modelObject.destroy where, (error, result)->
            return cb error if error
            cb null, result
        insert : (cb)->
          return cb null, null if resultClassify.listCreate.length < 1
          modelObject.create(resultClassify.listCreate).exec (error, result)->
            return cb error if error
            cb null, result
        update : (cb)->
          return cb null, null if resultClassify.listUpdate.length < 1
          async.each resultClassify.listUpdate, (item, cb)->
            where = {}
            where[attrIdNameOfOne] = idOfOne
            where[attrIdNameOfMore] = item[attrIdNameOfMore]
            modelObject.update where, item, (error, result)->
              return cb error if error
              cb null
          , (error)->
            return cb error, null if error
            cb null, resultClassify.listUpdate
      }, (error, result)->
        return callback MessageService.common.system error, null if error
        callback null, result


# Return: (true | false). If true then two object same
  compareObject : (objectFirt, objectSecond, byFieldList)->
    for aField in byFieldList
      unless objectFirt[aField] is objectSecond[aField]
        return false
    return true

  makeCode : ()->
    code = ''
    possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    i = 0
    while i < 8
      code += possible.charAt(Math.floor(Math.random() * possible.length))
      i++
    code

  sendEmail : (options, callback) ->
#generate body content for email
    compiler = jade.compileFile(options.contentTemplateUrl)
    mailContentHtml = compiler(options.content)

    #config for email
    if !options.from
      $from = sails.config.nodemailer.sender
    else
      $from = options.from
    $to = options.to
    mailOptions =
      from : $from
      to : $to
      subject : options.subject
      html : mailContentHtml

    transporter = nodemailer.createTransport (sails.config.nodemailer.transporterAccount)
    transporter.sendMail mailOptions, callback

  isNumber : (number) ->
    patt = /^[0-9]*$/
    return patt.test(number)

## @params configs = {valueType: {createdAt: 'unix_timestamp'}, defaultSortColumn: 'createdAt'}
  buildSortStatementForSqlQuery : (inputParam, configs) ->
    TYPE_NORMAL = 'normal'
    if !inputParam && _.isEmpty(configs)
      return ''

    if !inputParam && !configs.defaultSortColumn
      return ''
    sort = if typeof inputParam is 'string' then JSON.parse (inputParam) else inputParam

    if _.isEmpty(sort) && !configs.defaultSortColumn
      return ''

    if _.isEmpty(sort)
      sort = {}
      sort[configs.defaultSortColumn] = 1

    orderByKey = _.keys(sort)
    if _.isEmpty(configs) || !configs.valueType
      type = TYPE_NORMAL
    else
      type = configs.valueType[orderByKey[0]] || TYPE_NORMAL

    switch type
      when "unix_timestamp"
        sortStr = "UNIX_TIMESTAMP(#{orderByKey[0]})" + if sort[orderByKey[0]] is 1 then ' DESC' else ' ASC'
      else
        sortStr = orderByKey[0] + if sort[orderByKey[0]] is 1 then ' DESC' else ' ASC'

    return sortStr

  extendParamForSqlQuery : (params, sortConfigs) ->
    M_DATE_FORMAT = 'YYYY-MM-DD HH:mm:ss'

    limit = params.limit || 30
    offset = if params.page then (params.page - 1) * limit else 0
    toDate = if params.toDate then moment(params.toDate).format(M_DATE_FORMAT) else moment().startOf('day').format(M_DATE_FORMAT)
    fromDate = if params.fromDate then moment(params.fromDate).format(M_DATE_FORMAT) else moment().subtract(30, 'days').endOf('day').format(M_DATE_FORMAT)
    if params.export is 1 or params.export is true
      fromDate = if moment(toDate).subtract(60, 'days').isBefore(moment(fromDate)) then fromDate else moment(toDate).subtract(60, 'days').startOf('day').format(M_DATE_FORMAT)
    sort = @.buildSortStatementForSqlQuery(params.sort, sortConfigs)

    extendingParams = {
      limit : limit
      offset : offset
      toDate : toDate
      fromDate : fromDate
      sort : sort
    }
    _.extend params, extendingParams
