directive = ($rootScope, $document) ->
  link = ($scope, $element, $attr) ->
    $scope.$watch 'value', (data)->
      return if data is undefined
      $($element).tooltip({
        'title': data,
        'animation': true,
        'delay': { show: 100, hide: 100 }
      })
    , true
    return
  directive =
    restrict: 'A'
    scope   :
      value: '=ngValue'
#    templateUrl: '/template/master/directive/datatable/view.html'
    link    : link
  
  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "sbdTooltip", directive