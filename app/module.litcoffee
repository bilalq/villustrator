Villustrator
============
This is the main application module that loads and encapsulates all others.
Application wide configuration is also hosted here.

We define the main `Villustrator` module here and express all its dependencies.

    angular.module 'Villustrator', [
      'Villustrator.home'
      'Villustrator.fileManagement'
    ]

We also add in a routing rule to redirect unknown URLs to `/`.

    .config ($urlRouterProvider) ->
      $urlRouterProvider.otherwise '/'
