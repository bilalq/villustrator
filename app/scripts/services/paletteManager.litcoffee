paletteManager
==============
This service manages the terminal color palette used by color pickers. By
default, the palette will be the default palette from xterm-256color.

    'use strict'
    angular.module('Villustrator')
      .factory 'paletteManager', ($window, $rootScope) ->

The default palette comes from a library that expose itself in the UMD format.
Since no module loader (other than Angular's) is in use here, the palette is
instead exposed as a global called `xterm256ColorPalette` on the window object.

        defaultPalette = $window.xterm256ColorPalette

Whenever the palette is updated, we need to first validate that it is in the
right format.

        isValidColor = RegExp::test.bind /#[0-9a-f]{6}/
        validatePalette = (palette) ->
          throw new Error('Palette must contain 256 colors') if palette?.length isnt 256
          palette.forEach (color) ->
            throw new Error ("#{color} is an illegal color") unless isValidColor color

        $rootScope.terminal ||= palette: defaultPalette

        getPalette: -> $rootScope.terminal.palette

        changePalette: (newPalette) ->
          validatePalette newPalette
          $rootScope.terminal.palette = newPalette

        restoreDefaultPalette: -> @changePalette(defaultPalette)

