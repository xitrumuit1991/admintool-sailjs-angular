#directive = (ApiService, $rootScope, $document, UtitService, $timeout, AnalyticService, AnalyticHelperService) ->
#  link = ($scope, element, attr) ->
#    $scope.typeView = 'performance'
#    $scope.statisticForm = null
#    $scope.statistic = null
#    formPerformance = [
#      title : 'Display'
#      key : 'display'
#      subKey : 'display_avg'
#      label : 'Total'
#      subLabel : 'Daily Avg.'
#      type : 'number'
#      description : 'The number of time that a video content is loaded and display within the player before it get played. Each time an embeded code is changed, this event gets triggered.'
#    ,
#      title : 'Plays requested'
#      key : 'play_request'
#      subKey : 'play_request_avg'
#      label : 'Total'
#      type : 'number'
#      subLabel : 'Daily Avg.'
#      description : 'The number of time that the Play button is triggered either manually or automatically'
#    ,
#      title : 'Video Start'
#      key : 'video_start'
#      subKey : 'video_start_avg'
#      label : 'Total'
#      subLabel : 'Daily Avg.'
#      type : 'number'
#      description : 'The number of time that an actual non-ad video content starts playing. If a user click on the Play button and a pre-roll ad starts playing, the user  drops off before the actual video content start playing, this event wont be triggered'
#    ,
#      title : 'Replayed'
#      key : 'replayed'
#      subKey : 'replayed_avg'
#      label : 'Total'
#      subLabel : 'Daily Avg.'
#      type : 'number'
#      description : 'When video is replay after the end'
#    ,
#      title : 'Play Conversion Rate'
#      key : 'play_conv_rate'
#      label : 'Value'
#      type : 'percent'
#      description : 'Plays Requested/Displays'
#    ,
#      title : 'Video Conversion Rate'
#      key : 'video_conv_rate'
#      label : 'Value'
#      type : 'percent'
#      description : 'Video Starts/Play Requested'
#    ]
#
#    formEngament = [
#      title : 'Hours Watched'
#      key : 'hours_watched'
#      subKey : 'hours_watched_avg'
#      label : 'Total'
#      subLabel : 'Daily Avg.'
#      type : 'time'
#      description : 'The amount of time (in hour) all users spend watching the selected video asset(s), converted to HH:MM:SS format'
#    ,
#      title : 'Avg Time Watched per Video'
#      key : 'avg_time_watched'
#      label : 'Value'
#      type : 'time'
#      description : 'Hour watched/Video start, convert to HH:MM:SS format'
#    ]
#
#    formReach = [
#      title : 'Unique User'
#      key : 'unique_user'
#      subKey : 'unique_user_avg'
#      label : 'Total'
#      subLabel : 'Daily avg.'
#      type : 'number'
#      description : 'The number of unique users who request to play selected videos'
#    ,
#      title : 'Avg Play Request per User'
#      key : 'avg_play_request'
#      type : 'number'
#      description : 'Total play requested/Total unique user ( for the select date range)'
#    ]
#
#    formPlaythrought = [
#      title : 'Play Through 25%'
#      key : 'play_through_25'
#      subKey : 'play_through_25_avg'
#      label : 'Total'
#      subLabel : 'Daily avg.'
#      type : 'number'
#      description : 'The number of time that a video plays to 25% of its length. Please note: within the same video viewing session. If a user rewinds and watches through the 25% quartile multiple times, Playthrough 25% will only count one.'
#    ,
#      title : 'Play Through 50%'
#      key : 'play_through_50'
#      subKey : 'play_through_50_avg'
#      label : 'Total'
#      subLabel : 'Daily avg.'
#      type : 'number'
#      description : 'The number of time that a video plays to 50% of its length. Please note: within the same video viewing session. If a user rewinds and watches through the 50% quartile multiple times, Playthrough 50% will only count one.'
#    ,
#      title : 'Play Through 75%'
#      key : 'play_through_75'
#      subKey : 'play_through_75_avg'
#      label : 'Total'
#      subLabel : 'Daily avg.'
#      type : 'number'
#      description : 'The number of time that a video plays to 75% of its length. Please note: within the same video viewing session. If a user rewinds and watches through the 75% quartile multiple times, Playthrough 75% will only count one.'
#    ,
#      title : 'Play Through 100%'
#      key : 'play_through_100'
#      subKey : 'play_through_100_avg'
#      label : 'Total'
#      subLabel : 'Daily avg.'
#      type : 'number'
#      description : 'The number of time that a video plays to 100% of its length. Please note: within the same video viewing session. If a user rewinds and watches through the 100% quartile multiple times, Playthrough 100% will only count one.'
#    ]
#
#    #
#    #
#    #
#    #
#    extendColorChart = {
#      spanGaps : false
#      lineTension: 0,
#      fill : false,
#      borderCapStyle: 'butt',
#      borderDash: [],
#      borderDashOffset: 0.0,
#      borderJoinStyle: 'miter',
#      pointBorderColor: "white",
#      pointBackgroundColor: "black",
#      pointBorderWidth: 1,
#      pointHoverRadius: 8,
#      pointHoverBackgroundColor: "brown",
#      pointHoverBorderColor: "yellow",
#      pointHoverBorderWidth: 2,
#      pointRadius: 4,
#      pointHitRadius: 10,
#    }
#
#    dataSetPerformance = [
#      label : "Display",
#      backgroundColor : "#097cff",
#      borderColor: "#097cff",
#      name:'display'
#      data : []
#      id: "y-axis-0",
#      type:'line'
#    ,
#      label : "Plays requested",
#      backgroundColor : "#90be2e",
#      borderColor: "#90be2e",
#      name:'play_request'
#      data : []
#      id: "y-axis-0",
#      type:'line'
#    ,
#      label : "Video Starts",
#      backgroundColor : "#e65252",
#      borderColor: "#e65252",
#      name:'video_start'
#      data : []
#      id: "y-axis-0",
#      type:'line'
#    ,
#      label : "Replays",
#      backgroundColor : "#f0ad4e",
#      borderColor: "#f0ad4e",
#      name:'replayed'
#      data : []
#      id: "y-axis-0",
#      type:'line'
##    ,
##      label : "Play Conversion Rate",
##      backgroundColor : "#09f000",
##      borderColor: "#09f000",
##      name:'play_conv_rate'
##      data : []
##      yAxisID: "y-axis-1"
##      type : 'line'
##      borderDash: [5, 5],
##    ,
##      label : "Video Conversion Rate",
##      backgroundColor : "#000000",
##      borderColor: "#000000",
##      name:'video_conv_rate'
##      data : []
##      yAxisID: "y-axis-1"
##      type : 'line'
##      borderDash: [5, 5],
#    ]
#
#    dataSetEngament = [
#      label : "Avg Time Watched",
#      backgroundColor : "#097cff",
#      borderColor: "#097cff",
#      name:'avg_time_watched'
#      data : []
#    ,
#      label : "Hours Watched",
#      backgroundColor : "#f0ad4e",
#      borderColor: "#f0ad4e",
#      name:'hours_watched'
#      data : []
#    ]
#
#    dataSetReach = [
#      label : "Avg Play Request",
#      backgroundColor : "#097cff",
#      borderColor: "#097cff",
#      name:'avg_play_request'
#      data : []
#    ,
#      label : "Unique User",
#      backgroundColor : "#f0ad4e",
#      borderColor: "#f0ad4e",
#      name:'unique_user'
#      data : []
#    ]
#
#    dataSetPlaythrough = [
#      label : "Play Through 25%",
#      backgroundColor : "#097cff",
#      borderColor: "#097cff",
#      name:'play_through_25'
#      data : []
#    ,
#      label : "Play Through 50%",
#      backgroundColor : "#f0ad4e",
#      borderColor: "#f0ad4e",
#      name:'play_through_50'
#      data : []
#    ,
#      label : "Play Through 75%",
#      backgroundColor : "#90be2e",
#      borderColor: "#90be2e",
#      name:'play_through_75'
#      data : []
#    ,
#      label : "Play Through 100%",
#      backgroundColor : "#e65252",
#      borderColor: "#e65252",
#      name:'play_through_100'
#      data : []
#    ]
#
#
#
#
#    $scope.optionChart = {
#      type : 'line', #line
#      data : {
#        labels : [],
#        datasets : []
#      },
#      options : {
#        legend: {
#          display: true,
#          position: 'bottom',
#          labels: {
#            fontColor: "#000",
#          }
#        },
#        maintainAspectRatio : false,
#        spanGaps : false,
#        scales : {
#          yAxes: [
#            stacked: false,
#            position: "left",
#            type: 'linear',
#            id: "y-axis-0",
#            ticks : {
#              beginAtZero : false
#            }
##          ,
##            stacked: false,
##            position: "right",
##            type: 'linear',
##            id: "y-axis-1",
##            scaleLabel: {
##              display: true,
##              labelString: "Rate %",
##              fontColor: "green"
##              fontWeight: "bold"
##            }
#          ]
#        }
#      }
#    }
#
#    businessStatisticChart = new Chart(document.getElementById("businessStatisticChart"), $scope.optionChart)
#
#    $scope.param =
#      start_date : AnalyticHelperService.startDate()
#      end_date : AnalyticHelperService.endDate()
#      time_interval : "1d" #Time interval, ex: 1d, 1w, 1M.
#      interval : "1d" #Time interval, ex: 1d, 1w, 1M.
#
#    $scope.$watch 'start_date',(data)->
#      return unless data
#      if AnalyticHelperService.isDDMMYYYY(data)
#        $scope.param.start_date = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
#        $scope.loadDataChart()
#
#    $scope.$watch 'end_date',(data)->
#      return unless data
#      if AnalyticHelperService.isDDMMYYYY(data)
#        $scope.param.end_date = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
#        $scope.loadDataChart()
#
#    $scope.onChangeDayWeekMonth = (type)->
#      $scope.param.interval = type
#      $scope.param.time_interval = type
#      $scope.loadDataChart()
#
#
#    fillLabels = (result)->
#      $scope.optionChart.data.labels = []
#      _.map result.data,(item)->
#        date= moment( (new Date(parseInt(item.day))) ).format('DD/MM/YYYY')
#        $scope.optionChart.data.labels.push(date)
#
#    fillData = (result)->
#      $scope.optionChart.data.datasets = []
#      temp = []
#      if $scope.typeView ==  'performance'
#        temp = _.clone dataSetPerformance
#      if $scope.typeView ==  'playthought'
#        temp = _.clone dataSetPlaythrough
#      if $scope.typeView ==  'reach'
#        temp = _.clone dataSetReach
#      if $scope.typeView ==  'engament'
#        temp = _.clone dataSetEngament
#
#      _.map temp,(ite)->
#        ite.data = []
#        ite = _.mergeWith(ite,_.clone(extendColorChart))
##      console.log 'temp',temp
#      _.map result.data,(item)->
#        _.map item, (value, key)->
#          index = _.findIndex temp, {name:key}
#          temp[index].data.push( parseInt(value) ) if index != -1
##      console.log 'temp',temp
#      $scope.optionChart.data.datasets = temp
#      businessStatisticChart.update()
#
#
#    $scope.loadDataChart = ()->
#      switch $scope.typeView
#        when 'playthought'
#          $scope.statisticForm = formPlaythrought
#          AnalyticService.analytic.business.throughTotal((err, result)->
#            return if err or !result
#            $scope.statistic = result.data
#          , $scope.param)
#          AnalyticService.analytic.business.throughLine((err, result)->
#            return if err or !result
#            fillLabels(result)
#            fillData(result)
#          , $scope.param)
#          break
#
#        when 'reach'
#          $scope.statisticForm = formReach
#          AnalyticService.analytic.business.reachTotal((err, result)->
#            return if err or !result
#            $scope.statistic = result.data
#          , $scope.param)
#          AnalyticService.analytic.business.reachLine((err, result)->
#            return if err or !result
#            fillLabels(result)
#            fillData(result)
#          , $scope.param)
#          break
#
#        when 'engament'
#          $scope.statisticForm = formEngament
#          AnalyticService.analytic.business.engamentTotal((err, result)->
#            return if err or !result
#            $scope.statistic = result.data
#          , $scope.param)
#          AnalyticService.analytic.business.engamentLine((err, result)->
#            return if err or !result
#            fillLabels(result)
#            fillData(result)
#          , $scope.param)
#          break
#
#        when 'performance'
#          $scope.statisticForm = formPerformance
#          AnalyticService.analytic.business.performanceLine((err, result)->
#            return if err or !result
#            fillLabels(result)
#            fillData(result)
#          , $scope.param)
#          AnalyticService.analytic.business.performanceTotal((err, result)->
##            console.log 'performanceTotal', result
#            return if err or !result
#            $scope.statistic = result.data
#          , $scope.param)
#          break
#
#
#    $scope.$watch 'typeView', (data)->
#      $scope.loadDataChart()
#
#    return
#  directive =
#    restrict : 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
#    templateUrl : Templates['analytic.directive.businessStatistic']()
#    link : link
#
#  return directive
#directive.$inject = ['ApiService', '$rootScope', '$document', 'UtitService', '$timeout',
#  'AnalyticService', 'AnalyticHelperService'
#]
#angular.module 'sb-admin'
#  .directive "uizaBusinessStatistic", directive
