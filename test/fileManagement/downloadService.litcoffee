    describe 'downloadService', ->

      beforeEach module 'Villustrator.fileManagement'
      beforeEach inject (@downloadService) ->

      it 'has a download method', ->
        expect(@downloadService.download instanceof Function).toBe true


