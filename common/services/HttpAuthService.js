// Generated by CoffeeScript 1.7.1
'use strict';
MainModule.factory('HttpAuth', function($q, $http) {
  var HttpAuth;
  return HttpAuth = (function() {
    function HttpAuth() {}

    HttpAuth.get = function(url, params) {
      var deferred;
      deferred = $q.defer();
      $http.get(url, params).then(function(response) {
        return deferred.resolve(response);
      }, function(error) {
        return deferred.reject(error);
      });
      return deferred.promise;
    };

    HttpAuth.put = function(url, data, config) {
      var deferred;
      if (config == null) {
        config = null;
      }
      deferred = $q.defer();
      $http.put(url, data, config).then(function(response) {
        return deferred.resolve(response);
      }, function(error) {
        return deferred.reject(error);
      });
      return deferred.promise;
    };

    HttpAuth.post = function(url, data, config) {
      var deferred;
      if (config == null) {
        config = null;
      }
      deferred = $q.defer();
      $http.post(url, data, config).then(function(response) {
        return deferred.resolve(response.data);
      }, function(error) {
        return deferred.reject(error);
      });
      return deferred.promise;
    };

    HttpAuth["delete"] = function(url, config) {
      var deferred;
      if (config == null) {
        config = null;
      }
      deferred = $q.defer();
      $http["delete"](url, config).then(function(response) {
        return deferred.resolve(response);
      }, function(error) {
        return deferred.reject(error);
      });
      return deferred.promise;
    };

    return HttpAuth;

  })();
});

//# sourceMappingURL=HttpAuthService.map
