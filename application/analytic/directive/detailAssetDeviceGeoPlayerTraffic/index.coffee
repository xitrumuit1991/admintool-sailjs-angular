#directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, $stateParams, AnalyticHelperService) ->
#  link = ($scope, element, attr) ->
#    entityId = $stateParams.id || AnalyticHelperService.randomUuid()
#    $scope.activeBlock = 'device'
#    $scope.loadingTableData = false
#    $scope.param =
#      entity_id : entityId
#      start_date : AnalyticHelperService.startDate()
#      end_date : AnalyticHelperService.endDate()
#      type : 'device'
#
#    $scope.block = [
#      {
#        icon : 'icon-screen-desktop'
#        class : 'col-md-3'
#        color : '#3e4b5b'
#        colorActive : '#097cff'
#        title : 'Device'
#        description : 'Plays requested'
#        name : 'device'
#        active : true
#        data : []
#      },
#      {
#        icon : 'icon-globe'
#        class : 'col-md-3'
#        color : '#3e4b5b'
#        colorActive : '#90be2e'
#        title : 'Geography'
#        description : 'Plays requested'
#        name : 'geo'
#        data : []
#      },
#      {
#        icon : 'picons-thin-icon-thin-0158_arrow_next_right'
#        class : 'col-md-3'
#        color : '#3e4b5b'
#        colorActive : '#e65252'
#        title : 'Player'
#        description : 'Plays requested'
#        name : 'player'
#        data : []
#      },
#      {
#        icon : 'picons-thin-icon-thin-0539_map_path_navigation_location'
#        class : 'col-md-3'
#        color : '#3e4b5b'
#        colorActive : '#f0ad4e'
#        title : 'Traffic source'
#        description : 'Plays requested'
#        name : 'traffic'
#        data : []
#      }
#    ]
#
#
#    $scope.tableOptions = {
#      sideBarLeft : {
#        color : '#90be2e'
#        title : 'Geography'
#      }
#      data : [
#        title : 'Name'
#        key : 'name'
#        type : 'text'
#        sortAble : true
#      ,
#        title : 'Display'
#        key : 'display'
#        type : 'text'
#        sortAble : true
#      ,
#        title : 'PLAYERS REQURESTED'
#        key : 'play_request'
#        type : 'text'
#        sortAble : true
#      ,
#        title : 'REPLAYED'
#        key : 'replayed'
#        type : 'text'
#        sortAble : true
#      ,
#        title : 'VIDEO STARTS'
#        key : 'video_start'
#        type : 'text'
#        sortAble : true
#      ,
#        title : 'PLAY CONVERSION RATE'
#        key : 'play_conv_rate'
#        type : 'percent'
#        sortAble : true
#      ,
#        title : 'VIDEO CONVERSION RATE'
#        key : 'video_conv_rate'
#        type : 'percent'
#        sortAble : true
##      ,
##        title : 'HOURS WATCHED'
##        key : 'hours_watched'
##        type : 'time'
##        sortAble : true
##      ,
##        title : 'AVG. TIME WATCHED'
##        key : 'avg_time_watched'
##        type : 'time'
##        sortAble : true
#      ]
#    }
#    $scope.tableData = []
#
#    $scope.changeBlock = (ite)->
#      $scope.activeBlock = ite.name
#      _.map $scope.block, (item)->
#        if item.name == ite.name
#          item.active = true
#          $scope.param.type = ite.name
#          $scope.loadTableData()
#        else
#          item.active = false
#
#    $scope.loadDeviceGeoPlayerTraffic = ()->
#      fillDataToBlock = (name, result)->
#        index = _.findIndex $scope.block, {name : name}
#        if index != -1
#          $scope.block[index].data = []
#          _.map result.data, (item)->
#            $scope.block[index].data.push({
#              title : item.name
#              value : item.value
#              type : 'number'
#            })
#      arr = ['geo', 'player', 'traffic', 'device']
#      _.map arr, (item)->
#        AnalyticService.analytic.video[item]((err, result)->
#          return if err or !result
#          fillDataToBlock(item, result)
#        , $scope.param)
#
#
#    $scope.expandRow = (ite)->
#      _.map $scope.tableData,(item)->
#        if item.belongTo == ite.name
#          item.show = true
#        else if item.belongTo and item.belongTo != ite.name
#          item.show = false
#
#    checkNaNEmpty = (value)->
#      return 0 unless value
#      return 0 if isNaN(value) is true
#      return value
#
#
#    $scope.loadTableData = ()->
#      $scope.loadingTableData = true
#      AnalyticService.analytic.video.typePlayerTrafficGeoDeviceTable((err, result)->
#        return if err or !result
#        _.map result.data, (item)->
#          if item and item.value
#            item.display = 0
#            item.play_request = 0
#            item.video_start = 0
#            item.play_conv_rate = 0
#            item.video_conv_rate = 0
#            item.hours_watched = 0
#            item.avg_time_watched = 0
#            item.isParent = true
#            _.map item.value, (oneOs)->
#              item.display          +=  oneOs.display
#              item.play_request     +=  oneOs.play_request
#              item.video_start      +=  oneOs.video_start
#              item.play_conv_rate   +=  oneOs.play_conv_rate
#              item.video_conv_rate  +=  oneOs.video_conv_rate
#              item.hours_watched    +=  oneOs.hours_watched
#              item.avg_time_watched +=  oneOs.avg_time_watched
#              oneOs.belongTo = item.name
#              oneOs.name = oneOs.os
#              oneOs.show = false
#          else
#            item.isParent = false
#        #        console.log 'result.data',result.data
#        $scope.tableData = []
#        _.map result.data , (item)->
#          item.replayed = checkNaNEmpty(item.replayed)
#          item.display = checkNaNEmpty(item.display)
#          item.play_request = checkNaNEmpty(item.play_request)
#          item.video_start = checkNaNEmpty(item.video_start)
#          item.play_conv_rate = checkNaNEmpty(item.play_conv_rate)
#          item.video_conv_rate = checkNaNEmpty(item.video_conv_rate)
#          $scope.tableData.push(item)
#          if item and item.value
#            item.play_conv_rate = item.play_conv_rate/item.value.length if item.value.length > 0
#            item.video_conv_rate = item.video_conv_rate/item.value.length if item.value.length > 0
#            _.map item.value, (oneOs)->
#              oneOs.replayed = checkNaNEmpty(oneOs.replayed)
#              oneOs.display = checkNaNEmpty(oneOs.display)
#              oneOs.play_conv_rate = checkNaNEmpty(oneOs.play_conv_rate)
#              oneOs.play_request = checkNaNEmpty(oneOs.play_request)
#              oneOs.video_conv_rate = checkNaNEmpty(oneOs.video_conv_rate)
#              oneOs.video_start = checkNaNEmpty(oneOs.video_start)
#              if oneOs.belongTo == item.name
#                $scope.tableData.push(oneOs)
##        console.warn('$scope.tableData',$scope.tableData)
#        $scope.loadingTableData = false
#      , $scope.param)
#
#    $scope.loadDeviceGeoPlayerTraffic()
#    $scope.loadTableData()
#
#
#    $scope.$watch 'start_date',(data)->
#      return unless data
#      if AnalyticHelperService.isDDMMYYYY(data)
#        $scope.param.start_date = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
#        $scope.loadDeviceGeoPlayerTraffic()
#        $scope.loadTableData()
#
#    $scope.$watch 'end_date',(data)->
#      return unless data
#      if AnalyticHelperService.isDDMMYYYY(data)
#        $scope.param.end_date = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
#        $scope.loadDeviceGeoPlayerTraffic()
#        $scope.loadTableData()
#
#    return
#  directive =
#    restrict : 'E'
##    scope : {}
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
##      item: '=ngModel'
#    templateUrl : Templates['analytic.directive.detailAssetDeviceGeoPlayerTraffic']()
#    link : link
#
#  return directive
#directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', '$stateParams', 'AnalyticHelperService']
#angular
#  .module 'sb-admin'
#  .directive "uizaDetailAssetPlatform", directive
