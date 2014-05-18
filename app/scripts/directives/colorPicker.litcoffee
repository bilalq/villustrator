colorPicker Directive
=====================
This is a directive wrapper around the
[EightBitColorPicker Library](http://bilalq.github.io/eight-bit-color-picker).

    'use strict'
    angular.module('Villustrator')
    .directive 'colorPicker', (paletteManager, $window) ->

The color picker comes from a library that exposes itself in the UMD format.
Since no module loader (other than Angular's) is in use here, the library
exposes a global called `EightBitColorPicker` on the window. We get a reference
to it here via the `$window` injected by Angular.

      ColorPicker = $window.EightBitColorPicker

The directive can be used as either an element or attribute directive.

      restrict: 'EA'

The directive creates a child scope that prototypically inherits from the parent
scope. It only interacts with a `picker` property on the scope, and leaves
primitives alone.

      scope: true

The linking function ensures that two-way binding works on the picker
properties.

      link: (scope, element, attrs) ->
        scope.picker ||= {}
        pickerParams = el: element[0], color: scope.picker.color
        if scope.picker.palette then pickerParams.palette = scope.picker.palette

        picker = new ColorPicker pickerParams

        updateColor = (e) -> scope.$apply ->
          scope.picker.color = e.detail.newColor

        picker.addEventListener 'colorChange', updateColor

        scope.$on '$destroy', ->
          picker.removeEventListener 'colorChange', updateColor
