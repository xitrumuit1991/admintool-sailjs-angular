directive = ($rootScope, $document, $timeout) ->
  link = ($scope, element, attr) ->
    $scope.submit = ()->
    
    angular.element($document).ready(()->
      element.find('input.single-daterange').daterangepicker({
        "singleDatePicker": true,
        locale            : {
          format: 'DD-MM-YYYY'
        }
      })
#    element.find('input.multi-daterange').daterangepicker({"startDate" : "03/28/2017", "endDate" : "04/06/2017"})
    )
    $scope.$watch 'model', (data)->
      return unless data
      $scope.model = data || {}
    , true
  
  directive =
    restrict: 'EA'
    scope   :
      options: '=ngFormData'
      model  : '=ngModel'
    templateUrl: '/template/master/directive/formdata/view.html'
    link    : link
  
  return directive
directive.$inject = ['$rootScope', '$document', '$timeout']
angular
  .module 'sbd-admin'
  .directive "sbdFormData", directive