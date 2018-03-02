directive = ($rootScope, $document, $timeout) ->
  link = ($scope, element, attr) ->
    $rootScope.$watch 'user',(data)->
      return unless data
      $scope.user = data

    initMenuSlideUpDown = ()->
      $timeout(()->
        liTreeview = $('#menu-left-sidebar li.treeview')
        $(liTreeview).each ()->
          btn = $(this).children("a").first()
          menu = $(this).children(".treeview-menu").first()
          isActive = $(this).hasClass('active')
          if isActive
            menu.show()
            btn.children(".fa-angle-left").first().removeClass("fa-angle-left").addClass("fa-angle-down")
          btn.click (e)->
            e.preventDefault()
            if isActive
              menu.slideUp()
              isActive = false
              btn.children(".fa-angle-down").first().removeClass("fa-angle-down").addClass("fa-angle-left")
              btn.parent("li").removeClass("active")
            else
              menu.slideDown()
              isActive = true
              btn.children(".fa-angle-left").first().removeClass("fa-angle-left").addClass("fa-angle-down")
              btn.parent("li").addClass("active")
      ,500)

    $rootScope.$watch 'leftSidebar',(data)->
      return unless data
      $scope.menuleft = $rootScope.leftSidebar
      initMenuSlideUpDown()
    ,true

    return
  directive =
    restrict: 'E'
#    scope:
#      save : '='
#      cancel : '='
    templateUrl: '/template/master/directive/left_menu_sidebar/view.html'
    link    : link
  return directive
directive.$inject = ['$rootScope', '$document','$timeout']
angular
  .module 'sbd-admin'
  .directive "sbdLeftMenuSidebar", directive