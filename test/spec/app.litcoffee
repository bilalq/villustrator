    describe 'App', ->

      beforeEach module 'Villustrator'

      beforeEach inject (@dummy) ->

      it 'works', ->
        expect(@dummy.ok).toBe 343
