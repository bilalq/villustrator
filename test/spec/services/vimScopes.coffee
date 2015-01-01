'use strict'

describe 'Service: vimScopes', () ->

  # load the service's module
  beforeEach module 'Villustrator'

  # instantiate service
  vimScopes = {}
  beforeEach inject (_vimScopes_) ->
    vimScopes = _vimScopes_

  it 'should do something', () ->
    expect(!!vimScopes).toBe true
