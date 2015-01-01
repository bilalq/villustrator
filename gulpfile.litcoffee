Build Logic
===========
First, we load all the module dependencies we'll need. These will be shaped by
the stack choices in this project.

This is a purely static single page app, so there's no backend to speak of. The
stack looks like this:

* Build Tool: Gulp
* App Language: (Literate) CoffeeScript
* Stylesheet Language: SCSS
* Templating Language: Jade
* Package Manager: Bower
* Framework: Angular
* Test Runner: Karma
* Test Framework: Jasmine

    gulp = require('gulp')
    coffee = require('gulp-coffee')
    coffeelint = require('gulp-coffeelint')
    bower = require('gulp-bower')
    jade = require('gulp-jade')
    karma = require('karma')
    merge = require('merge-stream')


We're not using [wiredep][wiredep] here, so the only alternatives are to either
do a topological sort of our bower dependencies by parsing the `.bower.json`
files that get included as artifacts, or just manually list them out. There
aren't that many we need, so it's easiest to just do that.


Package Management
------------------
We'll define a little helper function that will prefix a given string (read:
dependency) with the Bower root directory.

    prefixWithBower = (dep) -> "app/bower_components/#{dep}"


Then follow through by defining all our dependencies.

    bowerScriptDeps: [
      'angular/angular.js'
      'angular-ui-router/release/angular-ui-router.js'
      'eight-bit-color-picker/lib/eight-bit-color-picker.js'
    ].map prefixWithBower

    bowerStyleDeps: [
      'eight-bit-color-picker/lib/eight-bit-color-picker.css'
    ].map prefixWithBower

    bowerTestDeps: [
      'angular-mocks/angular-mocks.js'
    ].map prefixWithBower


Linting
-------
Here we define our code linting tasks. Because we're using Literate
CoffeeScript everywhere outside of tests, our code naturally needs a bit more
indenting. 80 can feel cramped at times, so we bump up the limit to 100 and add
warnings for various stylistic violations.

Because of the way the plugin works, we need to make a distinction between our
app and test linting. Line numbers of Literate CoffeeScript files in the lint
report get thrown off if a boolean flag isn't marked as true, but setting it to
true also makes the linter ignore regular CoffeeScript files. Solution? Create
two separate streams and merge them.

    gulp.task 'lint', ->
      lintOptions =
        max_line_length: value: 100
        no_empty_functions: level: 'warn'
        no_empty_param_list: level: 'warn'
        no_unnecessary_double_quotes: 'warn'
        space_operators: 'warn'
        spacing_after_comma: 'warn'
      merge(
        gulp.src('./app/**/*.litcoffee').pipe coffeelint(lintOptions, true),
        gulp.src('./test/**/*.coffee').pipe coffeelint lintOptions
      )
      .pipe coffeelint.reporter()


Default Task
------------

    gulp.task 'default', ['lint']


<!-- Footnote Links -->
  [wiredep]: https://github.com/taptapship/wiredep
