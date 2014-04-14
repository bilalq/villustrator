'use strict'

angular.module('Villustrator', [
  'Villustrator.templates',
  'ngCookies',
  'ngSanitize',
  'ngRoute'
])
.config ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'views/main.html'
    controller: 'MainCtrl'
  .otherwise
    redirectTo: '/'
