'use strict'

describe 'Service: paletteManager', () ->

  # load the service's module
  beforeEach module 'Villustrator'

  # instantiate service
  paletteManager = {}
  beforeEach inject (_paletteManager_) ->
    paletteManager = _paletteManager_

  it 'should do something', () ->
    expect(!!paletteManager).toBe true
