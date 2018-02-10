directive = (UtitService, $rootScope, $document) ->
  link = ($scope, element, attr) ->
    $scope.value = ''
    
    $scope.$watch 'model', (data)->
      return unless data
      key = $scope.key.split('.')
      if key
        _.map key, (item)->
          data = data[item] if item and data
      $scope.value = data
    , true
    
    
    $scope.onChange = (data)->
      key = $scope.key.split('.')
      switch key.length
        when 1
          $scope.model[key[0]] = data
        when 2
          $scope.model[key[0]][key[1]] = data
        else
          console.warn('This param not support change')
      UtitService.apply($scope)

    $scope.getIngestProfileName = ()->
      if $scope.option.type=="ingestProfile"
        idIngest = $scope.model[$scope.key]
        listIngest = $scope.option['options']
        index = _.findIndex(listIngest,{id : idIngest})
        return '' if !idIngest or !listIngest or index == -1
        return listIngest[index].name
  directive =
    restrict: 'E'
    scope   :
      key   : '=ngKey'
      option: '=ngOption'
      model : '=ngModel'
    templateUrl: '/template/master/directive/readObjectKey/view.html'
    link    : link
  
  return directive
directive.$inject = ['UtitService', '$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "readObjectKey", directive