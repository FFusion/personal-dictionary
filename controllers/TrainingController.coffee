#TrainingController#

'use strict';

MainModule.controller 'TrainingController', ($scope, Language, $timeout, $state, words, Notification) ->

    $scope.words = words.data;
    $scope.constant = Language;


    $scope.languages = [
        {
            id:1
            name:$scope.constant.russian.rus
            value:'rus'
        },
        {
            id:2
            name:$scope.constant.english.rus
            value:'eng'
        }
    ]

    $scope.training = {
        number:3,
        language:null
    }


    $scope.hide = (words, type) ->
        angular.forEach(words, (word)->
            if type == 'rus' then word.hideRus = true;
            if type == 'trans' then word.hideTrans = true;
            if type == 'eng' then word.hideEng = true;
        )


    $scope.compareRandom = (a, b) ->
        Math.random() - 0.5;



    $scope.getTrainingWords = () ->
        $scope.trainWords = [];

        if $scope.training.language isnt null
            $scope.trainWords = angular.copy($scope.words);
            $scope.trainWords.sort($scope.compareRandom);
            $scope.trainWords = $scope.trainWords.splice(0, $scope.training.number);

            $scope.hide($scope.trainWords, $scope.training.language.value);
        else
            Notification.error($scope.constants.noLanguage.rus);




    $scope.back = () ->
        window.history.back();