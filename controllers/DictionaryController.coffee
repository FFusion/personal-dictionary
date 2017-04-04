#DictionaryController#

'use strict';

MainModule.controller 'DictionaryController', ($scope, $state, $timeout, HttpAuth, Notification, Language, groups) ->

    $scope.groups = groups.data;
    $scope.showProperties = true;

    $scope.constant = Language;


    $scope.word = {
        eng:null
        rus:null
        group:null
    }

    $scope.group = {
        name:null
    }


    $scope.hideRus = false;
    $scope.hideTrans = false;
    $scope.hideEng = false;



    $scope.hideProperties = (group) ->
        group.show = !group.show;


    # открыть все
    $scope.showAllProperties = () ->
        $scope.showProperties = false;
        angular.forEach($scope.groups, (group)->
            group.show = true;
        )


    # закрыть все
    $scope.closeAllProperties = () ->
        $scope.showProperties = true;
        angular.forEach($scope.groups, (group)->
            group.show = false;
        )


    $scope.filterChange = () ->
        $scope.showProperties = true;
        angular.forEach($scope.groups, (group)->
            group.show = true;
        )


    $scope.hide = (property, type) ->
        angular.forEach(property.words, (word)->
            if type == 'rus' then word.hideRus = true;
            if type == 'trans' then word.hideTrans = true;
            if type == 'eng' then word.hideEng = true;
        )


    $scope.addGroup = () ->
        HttpAuth.post('main.php?act=addGroup',group:$scope.group).then(
            (response) ->
                Notification.show(response);
                $timeout(
                    location.reload();
                ,2000)
            (error) ->
                Notification.error(error);

        )


    $scope.addWord = () ->
        HttpAuth.post('main.php?act=addWord',words:$scope.word).then(
            (response) ->
                Notification.show(response);
                $timeout(
                    location.reload();
                ,3000)
            (error) ->
                Notification.error(error);

        )


    $scope.updateWordModal = (word) ->
        $scope.word = word;

        angular.forEach($scope.groups, (group)->
            if word.group_id == group.id
                word.group = group;
        )


    # перейти к тренировке
    $scope.trainig = () ->
        $state.transitionTo('trainig', {reload:true});


    $scope.removeWord = () ->
        #todo: удаление слова


    $scope.saveWord = () ->
        #todo: сохранение слова (обновление)