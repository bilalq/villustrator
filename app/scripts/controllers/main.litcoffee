    'use strict'

    angular.module('Villustrator')
    .controller 'MainCtrl', ($scope, vimScopes, paletteManager) ->

      $scope.pickers = vimScopes.map (vimScope) ->
        color: Math.floor Math.random() * 256
        palette: paletteManager.getPalette()
        desc: vimScope.desc
        vimScope: vimScope.vimScope

      $scope.picker ||= { color: 123 }

      $scope.paletteToggle = ->
        console.log arguments[0]

