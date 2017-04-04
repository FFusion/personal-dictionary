'use strict';

MainModule.factory 'HttpAuth', ($q, $http) ->
    class HttpAuth

        @get: (url, params) ->
            deferred = $q.defer();
            $http.get(url,params).then(
                (response) -> deferred.resolve(response);
                (error) -> deferred.reject(error);
            )
            deferred.promise;

        @put: (url, data, config = null) ->
            deferred = $q.defer();
            $http.put(url, data, config).then(
                (response) -> deferred.resolve(response);
                (error) -> deferred.reject(error);
            )

            deferred.promise;



        @post: (url, data, config = null) ->
            deferred = $q.defer();
            $http.post(url, data, config).then(
                (response) -> deferred.resolve(response.data);
                (error) -> deferred.reject(error);
            )

            deferred.promise;

        @delete: (url, config = null) ->
            deferred = $q.defer();

            $http.delete(url, config).then(
                (response) -> deferred.resolve(response);
                (error) -> deferred.reject(error);
            )

            deferred.promise;

