'use strict'

describe 'Service: downloadManager', () ->

  # load the service's module
  beforeEach module 'villustratorApp'

  # instantiate service
  downloadManager = {}
  beforeEach inject (_downloadManager_) ->
    downloadManager = _downloadManager_

  it 'should do something', () ->
    expect(!!downloadManager).toBe true
