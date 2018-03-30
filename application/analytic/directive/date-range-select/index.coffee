directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, AnalyticHelperService, $state) ->
  link = ($scope, element, attr) ->
    $scope.selectRange =
      start_date : moment().add(-7, 'days').format('DD/MM/YYYY')
      end_date : moment(new Date()).format('DD/MM/YYYY')
      perios : ''

    $scope.listSelectPeriods = [
      'label' : 'Today'
      'value' : 'today'
    ,
      'label' : 'Yesterday'
      'value' : 'yesterday'
    ,
      'label' : 'This week'
      'value' : 'thisWeek'
    ,
      'label' : 'Last week'
      'value' : 'lastWeek'
    ,
      'label' : 'This month'
      'value' : 'thisMonth'
    ,
      'label' : 'Last month'
      'value' : 'lastMonth'
    ,
      'label' : 'This year'
      'value' : 'thisYear'
    ,
      'label' : 'Last year'
      'value' : 'lastYear'
    ]

    $scope.$watch 'selectRange.perios', (data)->
      return unless data
      d = new Date()
      switch data
        when 'today'
          $scope.selectRange.start_date = moment(d).format('DD/MM/YYYY')
          $scope.selectRange.end_date = moment(d).format('DD/MM/YYYY')
          break
        when 'yesterday'
          $scope.selectRange.start_date = moment(d).add(-1, 'days').format('DD/MM/YYYY')
          $scope.selectRange.end_date = moment(d).format('DD/MM/YYYY')
          break
        when 'thisWeek'
          $scope.selectRange.start_date = moment().startOf('week').format('DD/MM/YYYY')
          $scope.selectRange.end_date =   moment().endOf('week').format('DD/MM/YYYY')
          break
        when 'lastWeek'
          $scope.selectRange.start_date = moment().startOf('week').add(-7, 'days').format('DD/MM/YYYY')
          $scope.selectRange.end_date =   moment().endOf('week').add(-7, 'days').format('DD/MM/YYYY')
          break
        when 'thisMonth'
          $scope.selectRange.start_date = moment().startOf('month').format('DD/MM/YYYY')
          $scope.selectRange.end_date =   moment().endOf('month').format('DD/MM/YYYY')
          break
        when 'lastMonth'
          $scope.selectRange.start_date = moment().subtract(1, 'months').startOf('month').format('DD/MM/YYYY')
          $scope.selectRange.end_date =   moment().subtract(1, 'months').endOf('month').format('DD/MM/YYYY')
          break
        when 'thisYear'
          $scope.selectRange.start_date = moment().startOf('year').format('DD/MM/YYYY')
          $scope.selectRange.end_date =   moment().endOf('year').format('DD/MM/YYYY')
          break
        when 'lastYear'
          $scope.selectRange.start_date = moment().subtract(1, 'years').startOf('year').format('DD/MM/YYYY')
          $scope.selectRange.end_date =   moment().subtract(1, 'years').endOf('year').format('DD/MM/YYYY')
          break
        else
          $scope.selectRange.start_date = moment(d).format('DD/MM/YYYY')
          $scope.selectRange.end_date = moment(d).format('DD/MM/YYYY')
          break
#      console.log '$scope.selectRange', $scope.selectRange


    $scope.$watch 'selectRange.start_date', (data)->
      return unless data
      if AnalyticHelperService.isDDMMYYYY(data)
        $scope.outputStartDate = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
      else
        $scope.outputStartDate = data
#      console.log '$scope.outputStartDate',$scope.outputStartDate


    $scope.$watch 'selectRange.end_date', (data)->
      return unless data
      if AnalyticHelperService.isDDMMYYYY(data)
        $scope.outputEndDate = moment(data, 'DD/MM/YYYY').format('YYYY-MM-DD')
      else
        $scope.outputEndDate = data
#      console.log '$scope.outputEndDate',$scope.outputEndDate

    return null
  directive =
    restrict : 'E'
    scope :
      outputStartDate : '=ngStartDate'
      outputEndDate : '=ngEndDate'
    templateUrl : '/template/analytic/directive/date-range-select/view.html'
    link : link
  return directive
directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'AnalyticHelperService', '$state']
angular
  .module 'sbd-admin'
  .directive "sbdDateRangeSelect", directive