_directive = ($interval, ApiService, UtitService, $rootScope, $timeout, $http, $state, $stateParams) ->
  link = ($scope, $element, $attr) ->
    $scope.tableLoading = true
    $scope.isCheckedAll = false
    $scope.keySearch = ''
    $scope.sort = {}
    $scope.filterByParams = {}
    
    $scope.addAction = (func)->
#      console.log('func:', func)
      if _.isFunction(func)
        return func($scope.callbackAdd)
      $state.go func
    
    calculateArrayItemCheck = ()->
      return _.filter($scope.data, {checked: true})
    
    $scope.checkedAll = ()->
      _.map $scope.data, (item, key)->
        if $scope.options.isCheckedAll is true
          item.checked = true
        else
          item.checked = false
    
    $scope.checkedOneItem = (type = 'import-data')->
      arrTmp = calculateArrayItemCheck()
      return UtitService.notify('Please select only one item to perform this action', 'danger') if arrTmp.length != 1 or !arrTmp[0]
      if type is 'import-data'
        $scope.options.importData(arrTmp)
    
    $scope.quickEditBySelectAction = ()->
      arrTmp = calculateArrayItemCheck()
      return UtitService.notify('Please select only one item to perform this action', 'danger') if arrTmp.length != 1 or !arrTmp[0]
      $scope.options.quickEdit(arrTmp[0], (item)->
        index = _.findIndex $scope.data, {id: item.id}
        $scope.data[index] = item if index != -1
      )
    
    $scope.quickViewBySelectAction = ()->
      arrTmp = calculateArrayItemCheck()
      return UtitService.notify('Please select only one item to perform this action', 'danger') if arrTmp.length != 1 or !arrTmp[0]
      $scope.options.quickView(arrTmp[0], (item)->
      )
    
    $scope.deactiveBySelectAction = ()->
      arrTmp = calculateArrayItemCheck()
      return UtitService.notify('Please select at least one item', 'danger') if arrTmp.length <= 0
      return unless confirm("Are you sure to deactive #{arrTmp.length} items!")
      $scope.options.deactiveBySelect(arrTmp, ()->
        $scope.onPageChange()
      )
    $scope.openDetailAction = ()->
      arrTmp = calculateArrayItemCheck()
      return UtitService.notify('Please select only one item', 'danger') if !arrTmp or arrTmp.length != 1
      $scope.options.edit(arrTmp[0]) if arrTmp and arrTmp[0] and _.isFunction($scope.options.edit)
    
    $scope.duplicateBySelectAction = ()->
      arrTmp = calculateArrayItemCheck()
      return UtitService.notify('Please select at least one item', 'danger') if arrTmp.length <= 0
      return unless confirm("Are you sure to duplicate #{arrTmp.length} items!")
      $scope.options.duplicateBySelect(arrTmp, (result)->
        if !result or result.length <= 0 then return
        $scope.options.totalItems = $scope.options.totalItems + result.length
        async.map result, (item)->
          $scope.data.push(item)
      )
    $scope.filterBy = (item)->
      $scope.filterByParams = item || {}
      getData()
    $scope.deleteBySelectAction = ()->
      arrTmp = calculateArrayItemCheck()
      return UtitService.notify('Please select at least one item', 'danger') if arrTmp.length <= 0
      return unless confirm("Are you sure to delete #{arrTmp.length} items!")
      $scope.options.deleteBySelect(arrTmp, (result)->
        if !result or result.length <= 0 then return
        $scope.options.totalItems = $scope.options.totalItems - result.length
        async.map result, (item)->
          index = _.findIndex $scope.data, {id: item.id}
          $scope.data.splice(index, 1)
      )
    
    $scope.listActionBySelectAction = (actionClick)->
      arrTmp = calculateArrayItemCheck()
      return UtitService.notify('Please select at least one item', 'danger') if arrTmp.length <= 0
      if _.isFunction(actionClick)
        actionClick(arrTmp)
    
    prepareSearchParam = ()->
      currentPage = if _.isUndefined($scope.options.currentPage) then 0 else $scope.options.currentPage
      limit = $scope.options.limit || 20
      searchBy = $scope.options.searchBy
      keySearch = $scope.keySearch
      sort = $scope.sort
      filterByParams = $scope.filterByParams
      extendSearch = $scope.options.extendSearch
      #      console.log(filterByParams)
      params = {
        limit: limit
        page : currentPage
      }
      params.sort = sort  if !_.isEmpty(sort)
      params[searchBy] = keySearch if !_.isEmpty(keySearch)
      params[filterByParams.searchBy] = filterByParams.value if !_.isEmpty(filterByParams.value)
      _.map extendSearch, (value, key)->
        params[key] = value
      return params
    
    getData = ()->
      doneGetData = (error, result)->
        return if error or !result or !result.items
        _.map result.items, (ite)->
          ite.checked = false
        if _.isFunction $scope.options.formatData
          $scope.data = $scope.options.formatData result.items
        else
          $scope.data = result.items
        $scope.options.totalItems = result.totalItems || result.total
        $scope.tableLoading = false
        $scope.options.callbackAfterInit($scope.data) if _.isFunction($scope.options.callbackAfterInit)

      param = prepareSearchParam()
      localStorage.limit = $scope.options.limit || 10
      if _.isString($scope.options.url)
        options =
          url   : $scope.options.url
          method: $scope.options.method || 'GET'
          data  : param
        ApiService.request options,doneGetData
        return
      if _.isFunction($scope.options.api)
        $scope.options.api(param, doneGetData)
    
    $scope.search = (keySearch)->
      $scope.keySearch = keySearch
      getData()
    
    $scope.onPageChange = () ->
      getData()
    
    $scope.callbackAdd = (item)->
      $scope.data.unshift(item)
      $scope.options.totalItems++
    
    $scope.callbackEdit = (item)->
      index = _.findIndex $scope.data, {id: item.id}
      $scope.data[index] = item
    
    $scope.callbackDelete = (error, result)->
      return if error
      #      index = _.findIndex $scope.data, {id: result[0].id} #why result[0], after delete cannot get result
      index = _.findIndex $scope.data, {id: result.id}
      $scope.data.splice(index, 1)
      $scope.options.totalItems--
    
    $scope.setOrder = (key, active)->
      return if active
      sort = {}
      if key
        $scope.options.asc = !$scope.options.asc
        $scope.options.orderBy = key
      else if $scope.options.orderBy
        key = $scope.options.orderBy
      if key and key.length > 0
        sort[key] = if $scope.options.asc then 0 else 1
      $scope.sort = sort
      getData()
    
    $scope.options =
      limits        : ['5', '10', '20', '50']
      queryWithParam: null #{channel:''}
      isCheckedAll  : false
      form          : [
        title: 'ID'
        key  : 'id'
        type : 'shortText'
      ,
        title: 'Title'
        key  : 'title'
        type : 'text'
      ,
        title: 'Status'
        key  : 'status'
        type : 'status'
      ]
      totalItems    : 20
      currentPage   : 1
      limit         : '10'
      orderBy       : ''
      searchBy      : 'title'
      asc           : true
      add           : null
    
    $scope.$watch 'table', (data)->
      return unless  data
      data.reload = $scope.onPageChange
      data.limit = localStorage.limit || 5
      $scope.options = _.extend $scope.options, data
      $scope.table.search = getData
      getData({})
    , true
    
    triggerRealtime = null
    $scope.$on '$destroy', ()->
      $interval.cancel(triggerRealtime)
    
    $scope.$watch 'realtime', (data)->
      return if data is undefined
      return $interval.cancel(triggerRealtime) unless data.trigger
      $interval.cancel(triggerRealtime)
      triggerRealtime = $interval(()->
        data.callback($scope.data)
      , data.time)
    , true
    
  directive =
    restrict: 'E'
    templateUrl: '/template/master/directive/datatable/view.html'
    scope   :
      table   : '=ngModel'
      realtime: '=ngRealtime'
    link    : link
  return directive
_directive.$inject = ['$interval', 'ApiService', 'UtitService', '$rootScope', '$timeout', '$http', '$state', '$stateParams']
angular
  .module 'sbd-admin'
  .directive "sbdDatatable", _directive
