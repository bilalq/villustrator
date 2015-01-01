Villustrator
============
This is the main application module.

    angular.module 'Villustrator', [
      'ngSanitize'
      'ui.router'
      'Villustrator.fileManagement'
      'Villustrator.previews'
    ]

    .config ($urlRouterProvider) ->
      $urlRouterProvider.otherwise '/'

    .config ($stateProvider) ->
      $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'previews/foo'

