"use strict"
angular.module('sbd-admin').filter('uizaDateFormat', ()->
  return (value, format = "DD/MM/YYYY", zone = '+00')->
    return if _.isEmpty(value)
    d = moment(value)
    if d.isValid()
      if _.isNumber(value)
        return moment(value).format(format)
      return moment("#{value}").format(format)
    return ''
);