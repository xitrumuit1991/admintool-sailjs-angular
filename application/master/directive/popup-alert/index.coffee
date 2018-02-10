directive = ($rootScope, $document) ->
  link = ($scope, element, attr) ->
    $scope.modal =
      id : 'popup-alert'
      title : 'Notification'
      message : ''
      textBtnSave : 'OK'
      textBtnCancel : 'Cancel'
      show : ()->
        $("##{@.id}").modal('show')
      hide : ()->
        $("##{@.id}").modal('hide')

    $scope.saveAction = ()->
      $scope.modal.hide()

    $scope.cancelAction = ()->
#      console.log 'uizaPopupAlert click cancel'
      $scope.modal.hide()

    $rootScope.$on 'openPopupAlert',(event, data)->
      $scope.modal.title = data.title if data.title
      $scope.modal.message = data.message if data.message
#      $scope.save = data.save if data.save
      $scope.modal.show()
      if data.cancel and _.isFunction(data.cancel)
        $scope.cancelAction = ()->
          data.cancel()
          $scope.modal.hide()
      if data.save and _.isFunction(data.save)
        $scope.saveAction = ()->
#          console.log 'uizaPopupAlert click save'
          data.save()
          $scope.modal.hide()



  directive =
    restrict: 'E'
#    scope:
#      save : '='
#      cancel : '='
    templateUrl: '/template/master/directive/popup-alert/view.html'
    link    : link
  return directive
directive.$inject = ['$rootScope', '$document']
angular
  .module 'sbd-admin'
  .directive "sbdPopupAlert", directive