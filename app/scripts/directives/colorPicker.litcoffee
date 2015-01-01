colorPicker Directive
=====================
This is a directive wrapper around the
[EightBitColorPicker Library](http://bilalq.github.io/eight-bit-color-picker).

    'use strict'
    angular.module('Villustrator')
    .directive 'colorPicker', ($window) ->

The color picker comes from a library that exposes itself in the UMD format.
Since no module loader (other than Angular's) is in use here, the library
exposes a global called `EightBitColorPicker` on the window. We get a reference
to it here via the `$window` injected by Angular.

      ColorPicker = $window.EightBitColorPicker

The directive can be used as either an element or attribute directive.

      restrict: 'EA'

The directive creates an isolated scope that maintains two-way binding to
the references set in its `color` and `palette` attributes.

      scope:
        color: '='
        palette: '='

The linking function ensures that two-way binding works on the picker
color.

      link: (scope, element, attrs) ->
        pickerParams = el: element[0], color: scope.color
        if scope.palette then pickerParams.palette = scope.palette

        picker = new ColorPicker pickerParams
        scope.color ||= picker.get8BitColor()

        scope.$watch 'color', ->
          picker.updateColor scope.color

        updateColor = (e) -> scope.$apply ->
          scope.color = e.detail.newColor

        picker.addEventListener 'colorChange', updateColor
        scope.$on '$destroy', ->
          picker.removeEventListener 'colorChange', updateColor

        scope.$watch 'palette', ->
          #console.log 'palette change'
