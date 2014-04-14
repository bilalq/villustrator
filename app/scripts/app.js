'use strict';

angular.module('villustratorApp', [
  'ngSanitize',
  'ngRoute',
  'villustratorTemplates'
])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
