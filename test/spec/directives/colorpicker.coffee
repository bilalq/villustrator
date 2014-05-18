'use strict'

describe 'Directive: colorPicker', () ->

  # load the directive's module
  beforeEach module 'villustratorApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<color-picker></color-picker>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the colorPicker directive'
