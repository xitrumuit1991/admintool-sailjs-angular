AuthInterceptor = ($rootScope, $q) ->
  request : (config) ->
    return config
  response : (response) ->
    return response;
  responseError : (response) ->
    $q.reject response
AuthInterceptor.$inject = ["$rootScope", "$q"]
angular
.module("sbd-admin")
.factory "AuthInterceptor", AuthInterceptor
