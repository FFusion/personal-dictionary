#config#

'use strict';

MainModule.config ['$httpProvider', '$locationProvider', '$stateProvider', '$urlRouterProvider', '$sceDelegateProvider'
    ($httpProvider, $locationProvider, $stateProvider, $urlRouterProvider, $sceDelegateProvider) ->
        $httpProvider.defaults.useXDomain = true;

        delete $httpProvider.defaults.headers.common['X-Requested-With'];

        $httpProvider.defaults.headers.common =
            'Accept': 'application/hal+json'

        $httpProvider.defaults.headers.post =
            'Content-Type': 'application/json'


        # включаем html5-режим работы с урлами
        $locationProvider.html5Mode(true);
        $locationProvider.hashPrefix('!');

        $sceDelegateProvider.resourceUrlWhitelist(['**']);

        $stateProvider


        .state('dictionary',
            url:'/',
            controller:'DictionaryController',
            templateUrl:'views/dictionary.html',
            resolve:
                groups: (HttpAuth) ->
                    HttpAuth.get('main.php?act=getAll');
        )

        .state('trainig',
                url:'/trainig',
                controller:'TrainingController',
                templateUrl:'views/training.html',
                resolve:
                    words: (HttpAuth) ->
                        HttpAuth.get('main.php?act=getWords');
            )


        $urlRouterProvider.otherwise('/');
    ]


