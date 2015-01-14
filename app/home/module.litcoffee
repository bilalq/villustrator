Home
====
This is the module for the home page.

    angular.module 'Villustrator.home', [
      'ui.router'
    ]

We register the root URL state here and bind it to the correct contoller and
template.

    .config ($stateProvider) ->
      $stateProvider
      .state 'home',
        url: '/'
        controller: 'HomeCtrl as home'
        templateUrl: 'home/index'
