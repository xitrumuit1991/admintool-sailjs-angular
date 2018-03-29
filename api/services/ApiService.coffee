_request = require('request')
queryString = require('query-string');

exports.request = (options = {}, done)->
  options.headers = _.extend((options.headers || {}), { 'Content-Type' : 'application/json' })
  if options and !options.method then options.method = 'GET'
  if options and options.method in ['get','GET']
    if options.data || options.form || options.body
      queryUrlParam = options.data || options.form || options.body
      options.url = options.url +'?'+ queryString.stringify(queryUrlParam)
      delete options.data
      delete options.form
      delete options.body

  sails.log.info 'options',options
  _request options, (error, response, body) ->
    if error
      sails.log.error('error',error)
      sails.log.error('statusCode=',response?.statusCode)
      sails.log.error('JSON.stringify(body)=',JSON.stringify(body))
      return done(error, null)

    if !response or !body
      return done( {'statusCode' : response.statusCode, error : 'No data response or body' } , null)

    if response and response.statusCode isnt 200
      sails.log.error('response.statusCode isnt 200')
      sails.log.error('error',error)
      sails.log.error('statusCode=',response?.statusCode)
      sails.log.error('JSON.stringify(body)=',JSON.stringify(body))
      return done( {'statusCode' : response.statusCode, error : body}, null)

    if response and response.statusCode is 200
      return done(null, body)

    return done(null, body)
