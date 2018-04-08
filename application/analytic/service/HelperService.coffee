_service = ($rootScope, $http, GlobalConfig, UtitService, uuid, ApiService)->
  self = @
  self.mapCityNameCityCode = (cityName)->
    cityCodeGG = [
      {nameGG: 'Điện Biên', nameApi:'Điện Biên'}
      {nameGG: 'Hòa Bình', nameApi:'Hòa Bình'}
      {nameGG: 'Lai Châu', nameApi:'Lai Châu'}
      {nameGG: 'Lào Cai', nameApi:'Lào Cai'}
      {nameGG: 'Sơn La', nameApi:'Sơn La'}
      {nameGG: 'Yên Bái', nameApi:'Yên Bái'}
#      {nameGG : 'VN-HN', nameApi : 'Hanoi' },
#      {nameGG : "VN-CT", nameApi : "" },
#      {nameGG : "VN-CT", nameApi : "Bien Hoa" },
    ]
    index = _.findIndex(cityCodeGG, {nameApi : cityName})
    if index != -1
      return cityCodeGG[index].nameGG
    return cityName

  self.sortKeyOfObject = (obj) ->
    keys = []
    sorted_obj = {}
    for key of obj
      if obj.hasOwnProperty(key) then keys.push(key)
    # sort keys
    keys.sort()
    # create new array based on Sorted Keys
    _.map keys, (key)->
      sorted_obj[key] = obj[key]
    return sorted_obj


  self.randomName = ()->
    name = [
      'Avengers: Cuộc Chiến Vô Cực Của Marvel Studios | Teaser Trailer'
      'LẠ LÙNG / Vũ. (Original)'
      'Flatliners / Trải Nghiệm Điểm Chết" Trailer'
      'SampleVideo_1280x720_30mb'
      'Clip 2phut SampleVideo_1280x720_30mb'
      'Vô Cực Của Marvel Studios'
    ]
    return name[_.random(0, name.length-1)]

  self.isDDMMYYYY = (input)->
    pattern = /^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/
    return pattern.test(input)

  self.startDate = (input)->
    d =  if input then (new Date(input)) else (new Date())
#    return moment(d).add(-1,'days').format('YYYY-MM-DD')
    return moment(d).format('YYYY-MM-DD')

  self.endDate = (input)->
    d =  if input then (new Date(input)) else (new Date())
    return moment(d).format('YYYY-MM-DD')

  self.randomUuid = ()->
    return uuid.v4()

  self.randomImage = ()->
    return "img/demo#{_.random(1,10)}.jpg"
#    arrImage = []
#    return arrImage[_.random(0, arrImage.length-1)]

  self.dynamicColors = ()->
    r = Math.floor(Math.random()*255);
    g = Math.floor(Math.random()*255);
    b = Math.floor(Math.random()*255);
    return "rgb("+r+","+g+","+b+")"

  self.secondToHHmmss = (sec_num, format = null)->
    hours   = Math.floor(sec_num / 3600)
    minutes = Math.floor((sec_num - (hours * 3600)) / 60)
    seconds = sec_num - (hours * 3600) - (minutes * 60)
    returnText = ''
    if format is 'hh:mm:ss'
      if hours > 0
        if minutes <= 9 then returnText+= "0#{hours}:" else returnText+= "#{hours}:"
      else
        returnText+='00:'

      if minutes > 0
        if minutes <= 9 then returnText+= "0#{minutes}:" else returnText+= "#{minutes}:"
      else
        returnText+='00:'

      if seconds > 0
        if seconds <= 9 then returnText+= "0#{seconds}" else returnText+= "#{seconds}"
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

  self.randomCountryName = ()->
    data = [
      "Afghanistan",
      "Albania",
      "Algeria",
      "Andorra",
      "Angola",
#      "Antigua & Deps",
      "Argentina",
      "Armenia",
      "Australia",
      "Austria",
      "Azerbaijan",
      "Bahamas",
      "Bahrain",
      "Bangladesh",
      "Barbados",
      "Belarus",
      "Belgium",
      "Belize",
      "Benin",
      "Bhutan",
      "Bolivia",
      "Bosnia Herzegovina",
      "Botswana",
      "Brazil",
      "Brunei",
      "Bulgaria",
      "Burkina",
      "Burundi",
      "Cambodia",
      "Cameroon",
      "Canada",
      "Cape Verde",
      "Central African Rep",
      "Chad",
      "Chile",
      "China",
      "Colombia",
      "Comoros",
      "Congo",
      "Congo",
      "Costa Rica",
      "Croatia",
      "Cuba",
      "Cyprus",
      "Czech Republic",
      "Denmark",
      "Djibouti",
      "Dominica",
      "Dominican Republic",
      "East Timor",
      "Ecuador",
      "Egypt",
      "El Salvador",
      "Equatorial Guinea",
      "Eritrea",
      "Estonia",
      "Ethiopia",
      "Fiji",
      "Finland",
      "France",
      "Gabon",
      "Gambia",
      "Georgia",
      "Germany",
      "Ghana",
      "Greece",
      "Grenada",
      "Guatemala",
      "Guinea",
#      "Guinea-Bissau",
      "Guyana",
      "Haiti",
      "Honduras",
      "Hungary",
      "Iceland",
      "India",
      "Indonesia",
      "Iran",
      "Iraq",
      "Ireland",
      "Israel",
      "Italy",
      "Ivory Coast",
      "Jamaica",
      "Japan",
      "Jordan",
      "Kazakhstan",
      "Kenya",
      "Kiribati",
      "Korea North",
      "Korea South",
      "Kosovo",
      "Kuwait",
      "Kyrgyzstan",
      "Laos",
      "Latvia",
      "Lebanon",
      "Lesotho",
      "Liberia",
      "Libya",
      "Liechtenstein",
      "Lithuania",
      "Luxembourg",
      "Macedonia",
      "Madagascar",
      "Malawi",
      "Malaysia",
      "Maldives",
      "Mali",
      "Malta",
      "Marshall Islands",
      "Mauritania",
      "Mauritius",
      "Mexico",
      "Micronesia",
      "Moldova",
      "Monaco",
      "Mongolia",
      "Montenegro",
      "Morocco",
      "Mozambique",
      "Burma",
      "Namibia",
      "Nauru",
      "Nepal",
      "Netherlands",
      "New Zealand",
      "Nicaragua",
      "Niger",
      "Nigeria",
      "Norway",
      "Oman",
      "Pakistan",
      "Palau",
      "Panama",
      "Papua New Guinea",
      "Paraguay",
      "Peru",
      "Philippines",
      "Poland",
      "Portugal",
      "Qatar",
      "Romania",
      "Russian Federation",
      "Rwanda",
#      "St Kitts & Nevis",
      "St Lucia",
#      "Saint Vincent & the Grenadines",
      "Samoa",
      "San Marino",
#      "Sao Tome & Principe",
      "Saudi Arabia",
      "Senegal",
      "Serbia",
      "Seychelles",
      "Sierra Leone",
      "Singapore",
      "Slovakia",
      "Slovenia",
      "Solomon Islands",
      "Somalia",
      "South Africa",
      "South Sudan",
      "Spain",
      "Sri Lanka",
      "Sudan",
      "Suriname",
      "Swaziland",
      "Sweden",
      "Switzerland",
      "Syria",
      "Taiwan",
      "Tajikistan",
      "Tanzania",
      "Thailand",
      "Togo",
      "Tonga",
#      "Trinidad & Tobago",
      "Tunisia",
      "Turkey",
      "Turkmenistan",
      "Tuvalu",
      "Uganda",
      "Ukraine",
      "United Arab Emirates",
      "United Kingdom",
      "United States",
      "Uruguay",
      "Uzbekistan",
      "Vanuatu",
      "Vatican City",
      "Venezuela",
      "Vietnam",
      "Yemen",
      "Zambia",
      "Zimbabwe"
    ]
    return data[_.random(0, data.length-1)]

  return
_service.$inject = ['$rootScope', '$http', 'GlobalConfig', 'UtitService', 'uuid', 'ApiService']
angular.module('sbd-admin')
  .service('AnalyticHelperService', _service);

