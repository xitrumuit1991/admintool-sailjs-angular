directive = ($rootScope, $document, UtitService) ->
  link = ($scope, element, attr) ->
    dateFormat = "DD/MM/YYYY"
    initDatePicker = (date)->
      dateEl = $(element).find('input')
      dateEl.daterangepicker({
        singleDatePicker: true
        startDate       : date
        locale          :
          format: dateFormat
      })
      selectDate = (ev, picker) ->
        $scope.model = "#{dateEl.val()}"
        $scope.$apply()
      dateEl.on 'hide.daterangepicker', selectDate
      dateEl.on 'apply.daterangepicker', selectDate
    
    initDatePicker(moment().format(dateFormat))
    
    $scope.$watch 'model', (data)->
      return $scope.model = moment().format(dateFormat) if data in [undefined, null, 'Invalid date']
      initDatePicker(data)
    , true
  
  directive =
    restrict: 'E'
    scope   :
      model: '='
    templateUrl: '/template/master/directive/datePicker/view.html'
    link    : link
  
  return directive
directive.$inject = ['$rootScope', '$document', 'UtitService']
angular
  .module 'sbd-admin'
  .directive "sbdDatePicker", directive