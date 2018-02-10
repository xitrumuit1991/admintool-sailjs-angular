_config = ($stateProvider) ->
  $stateProvider.state "analytic.line-chart",
    url : "/line-chart"
    templateUrl  : '/template/analytic/controller/line-chart/view.html'
    controller: 'analytic.controller.line-chart.Ctrl'
_config.$inject = [ "$stateProvider"]

_run = ($rootScope)->
_run.$inject = ['$rootScope']

_controller = ($stateParams,$rootScope, $scope, $http, ApiService, UtitService, $state, $timeout, $location) ->
  id = $stateParams.id
  $scope.item = null
  $scope.selectRange =
    start_date : moment().add(-1,'days').format('DD/MM/YYYY')
    end_date : moment(new Date()).format('DD/MM/YYYY')
    perios : ''

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
    console.log '$scope.selectRange', $scope.selectRange

  $scope.listSelectPeriods = [
    'label' : 'To day'
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

  return

_controller.$inject = ['$stateParams', '$rootScope', '$scope', '$http', 'ApiService',
  'UtitService',
  '$state',
  '$timeout',
  '$location',
]

window.app
.config _config
.run _run
.controller 'analytic.controller.line-chart.Ctrl', _controller
