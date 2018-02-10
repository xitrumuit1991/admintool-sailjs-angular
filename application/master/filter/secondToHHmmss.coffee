"use strict"
filter = ($rootScope)->
  return (sec_num, format = null)->
    sec_num = parseInt(sec_num)
    hours   = Math.floor(sec_num / 3600);
    minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    seconds = sec_num - (hours * 3600) - (minutes * 60);
    returnText = ''
    if format == 'hh:mm:ss'
      if hours > 9
        returnText+= hours.toString()+':'
      else if hours >= 0 and hours <= 9
        returnText+= "0#{hours.toString()}:"
      if minutes > 9
        returnText+=minutes.toString()+':'
      else if minutes >= 0 and minutes <= 9
        returnText+= "0#{minutes.toString()}:"
      if seconds > 9
        returnText+=seconds.toString()
      else if seconds >=0 and seconds <= 9
        returnText+= "0#{seconds.toString()}"
      return returnText

    if hours > 0
      returnText+=hours+'h'
    if minutes > 0
      returnText+=minutes+'m'
    if seconds > 0
      returnText+=seconds+'s'
    return returnText
filter.$inject = ['$rootScope']
angular.module('sbd-admin').filter('secondToTime',filter)