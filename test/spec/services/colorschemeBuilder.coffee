'use strict'

describe 'Service: colorschemeBuilder', () ->

  # load the service's module
  beforeEach module 'Villustrator'

  # instantiate service
  colorschemeBuilder = {}
  beforeEach inject (_colorschemeBuilder_) ->
    colorschemeBuilder = _colorschemeBuilder_

  it 'should do something', () ->
    expect(!!colorschemeBuilder).toBe true
