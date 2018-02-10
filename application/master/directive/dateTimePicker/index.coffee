directive = ($rootScope, $document, UtitService) ->
  link = ($scope, element, attr) ->
    formatDate = 'DD/MM/YYYY HH:mm:ss'
    initDatePicker = (date)->
      dateEl = $(element).find('input')
      dateEl.daterangepicker({
        singleDatePicker   : true
        timePicker24Hour   : true,
        timePicker         : true,
        timePickerIncrement: 5,
        startDate          : if date then date else moment(new Date()).format(formatDate)
        locale             : {
          format: formatDate
        }
      })
      selectDate = (ev, picker) ->
        $scope.model = dateEl.val()
        $scope.$apply()
      
      dateEl.on 'hide.daterangepicker', selectDate
      dateEl.on 'apply.daterangepicker', selectDate
    initDatePicker(moment().format(formatDate))
    
    $scope.$watch('model', (data)->
      return $scope.model = moment().format(formatDate) if data in [undefined, null, 'Invalid date']
      initDatePicker(data)
    , true)
  
  directive =
    restrict: 'E'
    scope   :
      model: '='
    templateUrl: '/template/master/directive/dateTimePicker/view.html'
    link    : link
  
  return directive
directive.$inject = ['$rootScope', '$document', 'UtitService']
angular
  .module 'sbd-admin'
  .directive "sbdDatetimePicker", directive