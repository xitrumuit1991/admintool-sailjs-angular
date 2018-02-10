#directive = (AnalyticService, ApiService, $rootScope, $document, UtitService, $timeout, PlayerService, $stateParams, AnalyticHelperService, ApiMediaService) ->
#  link = ($scope, element, attr) ->
#    entityId = $stateParams.id
#    if _.isUuid(entityId)
#      $(angular.element.find('#video-player-analytic-entity')).html PlayerService.generatePreviewEmbedCode(entityId, null, '100%', '100%', false, 'position:absolute')
#      ApiMediaService.entity.get((err, result)->
#        return if err or !result or !result.item
#        $scope.item =  result.item
#      ,{id :  entityId})
#    return
#  directive =
#    restrict : 'E'
#    scope :
#      start_date : '=ngStartDate'
#      end_date : '=ngEndDate'
#    templateUrl : Templates['analytic.directive.detailAssetPlayer']()
#    link : link
#
#  return directive
#directive.$inject = ['AnalyticService', 'ApiService', '$rootScope', '$document', 'UtitService', '$timeout', 'PlayerService', '$stateParams', 'AnalyticHelperService', 'ApiMediaService']
#angular
#.module 'sb-admin'
#.directive "uizaDetailAssetPlayer", directive
