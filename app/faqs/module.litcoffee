Home
====
This is the module for the FAQs page.

    angular.module 'Villustrator.faqs', [
      'ngSanitize'
      'ui.router'
    ]

We register the faqs state here and bind it to the correct template. Our
controller does nothing more than pass through a reference to the questions
constant.

    .config ($stateProvider) ->
      $stateProvider
      .state 'faqs',
        url: '/faqs'
        controller: (@questions) ->
        controllerAs: 'faqs'
        templateUrl: 'faqs/show'

