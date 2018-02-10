_service = ($timeout, $rootScope, $state, notify, uuid, GlobalConfig)->
  self = @
  self.btnClass = [
    'btn bg-maroon btn-flat',
    'btn bg-orange btn-flat',
    'btn bg-purple btn-flat',
    'btn bg-navy btn-flat',
    'btn bg-olive btn-flat',
  ]

  self.bgClass=[
    'bg-aqua',
    'bg-green',
    'bg-yellow',
    'bg-red',
    'bg-primary',
    'bg-success',
    'bg-warning',
    'bg-info',
    'bg-danger',
  ]

  self.setUpNotify = ()->
  self.formatTimezone = (data = [])->
    dataTimeZone = []
    _.map data, (item)->
      dataTimeZone.push {
        id      : item.id
        timeZone: "#{item.timeZone} #{item.UTCDSTOffset}"
      }
    return dataTimeZone

  self.openTab = (name, param)->
    return unless name
    url = $state.href(name, param);
    window.open(url, '_blank');

  self.apply = (scope)->
    setTimeout(()->
      scope.$apply()
    , 1)

  self.dataURItoBlob = (dataURI) ->
# convert base64 to raw binary data held in a string
# doesn't handle URLEncoded DataURIs - see SO answer #6850276 for code that does this
    byteString = atob(dataURI.split(',')[1])
    # separate out the mime component
    #    mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]
    # write the bytes of the string to an ArrayBuffer
    ab = new ArrayBuffer(byteString.length)
    ia = new Uint8Array(ab)
    i = 0
    while i < byteString.length
      ia[i] = byteString.charCodeAt(i)
      i++
    # write the ArrayBuffer to a blob, and you're done
    bb = new Blob([ab]);
    return bb

  self.getFileNameByDatetime = (filename)->
    fileExtension = filename.split '.'
    ext = fileExtension.pop()
    name = fileExtension.join ''
    url = "#{self.stringToSlug(filename)}_#{new Date().getTime()}.#{ext}"
    return {
      name: name
      url : url
      ext : ext
    }

  self.convertAccentedToUnsigned = (text) ->
    valueMap =
      'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ|À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ|å': 'a'
      'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ|È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ|ë'                        : 'e'
      'ì|í|ị|ỉ|ĩ|Ì|Í|Ị|Ỉ|Ĩ|î'                                                : 'i'
      'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ|Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ|ø': 'o'
      'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ|Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ|ů|û'                      : 'u'
      'ỳ|ý|ỵ|ỷ|ỹ|Ỳ|Ý|Ỵ|Ỷ|Ỹ'                                                  : 'y'
      'đ|Đ'                                                                  : 'd'
      'ç'                                                                    : 'c'
      'ñ'                                                                    : 'n'
      'ä|æ'                                                                  : 'ae'
      'ö'                                                                    : 'oe'
      'ü'                                                                    : 'ue'
      'Ä'                                                                    : 'Ae'
      'Ü'                                                                    : 'Ue'
      'Ö'                                                                    : 'Oe'
      'ß'                                                                    : 'ss'
    for key, val of valueMap
      regex = new RegExp(key, 'gi');
      text = text.trim().replace(regex, val)
    return text.toLowerCase()

  self.stringToSlug = (text = '', replace = '-')->
    text = self.convertAccentedToUnsigned(text)
    valueMap =
      'space'     : replace
      'noneOfWord': ''
    for key, val of valueMap
      regex = new RegExp(key, 'gi');
      if key is 'space'
        regex = /(\s)+/g
      if key is 'noneOfWord'
        regex = /[^a-zA-Z0-9\-]/g
      text = text.trim().replace(regex, val)
    return text.toLowerCase()


  self.randomString = (len, type = 'lower', mixed = false)->
    result = ''
    i = len || 10
    if type == 'lower' then chars = 'abcdefghijklmnopqrstuvwxyz'
    if type == 'upper' then chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if type == 'number' then chars = '0123456789'
    if mixed == true and type != 'number' then chars += '0123456789'
    while i > 0
      result += chars[Math.floor(Math.random() * chars.length)]
      i--
    return result

  self.randomTime = (start = null, end = null)->
    start = new Date() unless  start
    unless end
      d = new Date()
      d.setDate(d.getDate() + 100)
      end = d
    diff = end.getTime() - start.getTime()
    new_diff = diff * Math.random()
    date = new Date(start.getTime() + new_diff)
    return moment(date).format('DD-MM-YYYY HH:MM:SS')

  self.notify = (message = '', type = 'success')->
    classes = {
      success: 'alert-info'
      info: 'alert-info'
      danger : 'alert-danger'
      error : 'alert-danger'
      warning : 'alert-warning'
    }
    message = if message and message.data and message.data.message then message.data.message else message
    return notify({message: message, duration: 5000, position: 'right', classes: classes[type]})

  self.notifySuccess = (message = '')->
    return notify({message: message, duration: 5000, position: 'right', classes: 'alert-info'})

  self.notifyError = (message = '')->
    return notify({message: message, duration: 5000, position: 'right', classes: 'alert-danger'})

  self.convertUrlToTitle = (url)->
    return '' unless  url
    tmpUrl = ''
    tmpUrl = url.substring(url.lastIndexOf('/') + 1)
    return '' unless tmpUrl
    tmpUrl = tmpUrl.replace(/.mp4$/, '')
      .replace(/.avi$/, '')
      .replace(/.flv$/, '')
      .replace(/.m4v$/, '')
      .replace(/.mkv$/, '')
      .replace(/.mov$/, '')
      .replace(/.mpeg$/, '')
      .replace(/.wmv$/, '')
      .replace(/.mpg$/, '')
      .replace(/.webm$/, '')
      .replace(/.vob$/, '')
      .replace(/.3gp$/, '')
    return tmpUrl


  self.alert = (data)->
#    dataconfig =
#      title : ''
#      message : ''
#      save :()->
#      cancel :()->
    $rootScope.$emit 'openPopupAlert', data

  self.formatBytes = (bytes)->
    return '' if !bytes or isNaN(bytes)
    if(bytes < 1024)
      return "#{bytes} Bytes"
    if(bytes < 1048576)
      return "#{(bytes / 1024).toFixed(1)} KB"
    if(bytes < 1073741824)
      return "#{(bytes / 1048576).toFixed(1)} MB"
    return "#{(bytes / 1073741824).toFixed(1)} GB"

  self.secondToHHmmss = (sec_num, type ='')->
    hours   = Math.floor(sec_num / 3600);
    minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    seconds = sec_num - (hours * 3600) - (minutes * 60);
    returnText = ''
    if type == 'hh:mm:ss'
      if hours > 0 then returnText+=hours+':'
      if minutes > 0
        if minutes > 9 then returnText+=minutes+':' else returnText+='0'+minutes+':'
      else
        returnText+='00:'
      if seconds > 0
        if minutes > 9 then returnText+=seconds else returnText+='0'+seconds
      else
        returnText+='00'
      return returnText

    if hours > 0
      returnText+=hours+'h'
    if minutes > 0
      returnText+=minutes+'m'
    if seconds > 0
      returnText+=seconds+'s'
    return returnText

  self.prepairParamSearchAdvance = (config)->
    removeEmpty = (obj) ->
      Object.keys(obj).forEach (key) ->
        if !_.isEmpty(obj[key]) and _.isObject(obj[key])
          removeEmpty(obj[key])
        else if _.isEmpty(obj[key])
          delete obj[key]
      return obj

    param = {
      entity:{
        name : '' # 'All Falls Down'
        description:''
        shortDescription:''
      }
      metadata:{
        type :  '' # 'tag'
        name : '' # can array
        slug : ''
      }
      fromDate : ''
      toDate   : ''
      dateRange : '' # 'createdAt' 'updatedAt'
    }

    if config['textToInclude']['condition'] and config['textToInclude']['value']
      param.entity[config['textToInclude']['condition']] = config['textToInclude']['value']

    if config['dateRange']['dataRange'] and config['dateRange']['fromDate'] and config['dateRange']['toDate']
      param.dateRange = config['dateRange']['dataRange']
      param.fromDate = config['dateRange']['fromDate']
      param.toDate = config['dateRange']['toDate']
    paramFinal = removeEmpty(param)
    console.log 'paramFinal',paramFinal
    return paramFinal

  return null
_service.$inject = ['$timeout', '$rootScope', '$state', 'notify', 'uuid', 'GlobalConfig']

angular
  .module('sbd-admin')
  .service('UtitService', _service);


