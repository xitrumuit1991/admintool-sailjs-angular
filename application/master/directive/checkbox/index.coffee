directive = ($rootScope, $document) ->
  link = ($scope, element, attr) ->
    $scope.value = false
    select = {
      '1': true
      '0': false
    }
    $scope.$watch 'config', (data)->
      return if data is undefined
      select = data
    
    $scope.$watch 'model', (value)->
      $scope.value = select[value]
    
    $scope.$watch 'value', (data)->
      _.map select, (item, key)->
        value = 0
        try
          
          value = parseInt(key)
        catch e
          value = key
        
        if item is data
          $scope.model = value
  
  directive =
    restrict: 'E'
    scope   :
      config: '=ngConfig'
      model : '=ngModel'
      title : '=ngTitle'
      disabled : '=ngDisabled'
    templateUrl: '/template/master/directive/checkbox/view.html'
    link    : link
  
  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "sbdCheckbox", directive