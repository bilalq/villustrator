Gulpfile
========
This file is home to all the build logic of this application.

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
* Development Server: st + livereload

We'll start off by requiring all the modules we need to define our build logic.

    # Utility modules
    gulp = require 'gulp'
    gutil = require 'gulp-util'
    concat = require 'gulp-concat'
    merge = require 'merge-stream'
    del = require 'del'

    # Development server modules
    http = require 'http'
    staticServer = require 'st'
    livereload = require 'gulp-livereload'

    # Transform modules
    coffee = require 'gulp-coffee'
    sass = require 'gulp-sass'
    sourcemaps = require 'gulp-sourcemaps'
    coffeelint = require 'gulp-coffeelint'
    uglify = require 'gulp-uglify'
    saveLicenses = require 'uglify-save-license'
    jade = require 'gulp-jade'
    wrapJS = require 'gulp-wrap-js'
    ngHtml2Js = require 'gulp-ng-html2js'
    ngAnnotate = require 'gulp-ng-annotate'

    # Programs
    bower = require 'bower'
    karma = require 'karma'


Constants
---------
We need to reference several key directories throughout our task definitions.
We define them here.

    buildDir = 'dist'
    bowerDir = 'bower_components'
    sourceMapDir = 'maps'


Dependencies
------------
We're not using [wiredep][wiredep] here, so the only alternatives are to either
do a topological sort of our bower dependencies by parsing the `.bower.json`
files that get included as artifacts, or just manually list them out. There
aren't that many we need, so it's easiest to just do that.


We'll define a little helper function that will prefix a given string (read:
dependency) with the Bower root directory.

    prefixWithBower = (dep) -> "#{bowerDir}/#{dep}"

Then follow through by defining all our dependencies here.

    bowerScriptDeps = [
      'angular/angular.js'
      'angular-sanitize/angular-sanitize.js'
      'angular-ui-router/release/angular-ui-router.js'
      'eight-bit-color-picker/lib/eight-bit-color-picker.js'
      'xterm-256color-palette/index.js'
    ].map prefixWithBower

    bowerStyleDeps = [
      'pure/pure.css'
      'eight-bit-color-picker/lib/eight-bit-color-picker.css'
    ].map prefixWithBower

    bowerTestDeps = [
      'angular-mocks/angular-mocks.js'
    ].map prefixWithBower

The actual `bower` task will just install dependencies.

    gulp.task 'bower', -> bower.commands.install()

And we'll have a separate `vendor` task to build vendor.js/css files.

    gulp.task 'vendor', ['bower'], ->
      merge(
        gulp.src bowerScriptDeps
        .pipe sourcemaps.init()
        .pipe concat 'vendor.js'
        .pipe uglify
          compress: { sequences: false, join_vars: false },
          preserveComments: saveLicenses
        .pipe sourcemaps.write sourceMapDir

        gulp.src bowerStyleDeps
        .pipe concat 'vendor.css'
      )
      .pipe gulp.dest buildDir
      .pipe livereload()


Templates
---------
We precompile our Jade templates and build them into Angular modules that write
to the `$templateCache` service. The module names will match whatever directory
any given template lives in. The `templateUrl` that identifies each template
will match the path to the template without the filetype suffix.

    gulp.task 'templates', ->
      gulp.src 'app/**/*.jade'
      .pipe jade doctype: 'html'
      .pipe ngHtml2Js
        declareModule: false
        moduleName: (file) -> "Villustrator.#{file.relative.split('/')[0]}"
        rename: (url) -> url.replace '.html', ''
      .pipe concat 'templates.js'
      .pipe gulp.dest buildDir
      .pipe livereload()


Linting
-------
For code linting, we use [coffeelint][coffeelint] and configure it using a JSON
file with many, many rules. Unfortunately, the ability to detect the usage of
undefined variables like JSHint does is not yet available. There is, however,
[this issue](https://github.com/clutchski/coffeelint/issues/20) tracking it.

    gulp.task 'lint', ->
      lintConfig = "config/coffeelint.json"
      gulp.src '@(app|test)/**/*.litcoffee'
      .pipe coffeelint 'config/coffeelint.json'
      .pipe coffeelint.reporter()


Scripts
-------
We compile our Literate CoffeeScript by taking it through a series of
transformations. We start off by compiling from coffee -> JS, then concatenate
all our code together into an `app.js` file, wrap the code in an IIFE that runs
in ES5 strict mode, run it through ngAnnotate to make the Angular dependency
injection minification safe, and finally pass it through to uglify to minify and
mangle.

    gulp.task 'scripts', ->
      gulp.src ['app/**/*.module.litcoffee', 'app/**/*.litcoffee']
      .pipe sourcemaps.init()
      .pipe coffee bare: true
      .on 'error', gutil.log
      .pipe concat 'app.js'
      .pipe wrapJS '(function(){ "use strict"; %= body % })()'
      .pipe ngAnnotate()
      .pipe uglify compress: { sequences: false, join_vars: false }
      .pipe sourcemaps.write sourceMapDir
      .pipe gulp.dest buildDir
      .pipe livereload()


Stylesheets
-----------
Stylesheets are written in SCSS syntax here, using gulp-scss as an abstraction
over node-scss. The ruby based one is a bit more featureful and has a more
extensive ecosystem around it (things like compass), but that alone isn't worth
adding ruby as a build dependency here.

    gulp.task 'styles', ->
      gulp.src 'styles/**/*.scss'
      .pipe sourcemaps.init()
      .pipe sass errLogToConsole: true, outputStyle: 'compressed'
      .pipe sourcemaps.write sourceMapDir
      .pipe gulp.dest buildDir
      .pipe livereload()


Static Assets
-------------
There are several static assets that can be copied into our build directory
without going through any transformations.

    gulp.task 'static', ->
      gulp.src 'static/**'
      .pipe gulp.dest buildDir
      .pipe livereload()


Testing
-------
We're using [Karma][karma] as our test runner. It's plugin ecosystem currently
has some limitations with regards to CoffeeScript support. Two problems have
been encountered:

* The coverage reporter can't seem to make sense of literate CoffeeScript.
* The coffee preprocessor can only handle all literate or no literate
  CoffeeScript. Mixing the two results in failure.

Because of these issues, coverage reports are not currently being built and
tests are being written using the literate syntax even though it's annoying.

The tests are configured to run in PhantomJS during development and in Firefox
when running on a CI server like Travis. Karma has its own mechanism for
watching, but for simplicity's sake, we just stick to single runs and let gulp
take care of watching.

    gulp.task 'test', ['vendor', 'templates'], (done) ->
      karma.server.start
        files: Array::concat.call(
          bowerScriptDeps,
          'app/**/*.module.litcoffee',
          'app/**/*.litcoffee',
          "#{buildDir}/templates.js",
          bowerTestDeps,
          'test/**/*.litcoffee'
        )
        singleRun: true
        frameworks: ['jasmine']
        browsers: if process.env.CI then ['Firefox'] else ['PhantomJS']
        reporters: ['progress', 'growl']
        preprocessors: { '@(app|test)/**/*.?(lit)coffee': 'coffee' }
        coffeePreprocessor:
          options: { bare: true, sourceMap: true, literate: true }
          transformPath: (path) -> path.replace /\.(lit)?coffee$/, '.js'
      , (exitCode) ->
        if process.env.CI then process.exit(exitCode) else done(exitCode)


Development Server
------------------
Starts up an HTTP server to be used for development. This is done just using
node's `http` module along with the `st` library.

    gulp.task 'server', (done) ->
      http.createServer staticServer
        path: buildDir
        index: 'index.html'
        cache: false
      .listen 4040, done


Default Task
------------
The default task is run when `gulp` is called without any arguments. We set it
to just go and build everything into our build directory.

    gulp.task 'default', [
      'vendor'
      'lint'
      'static'
      'styles'
      'scripts'
      'templates'
      'test'
    ]


Watch Task
----------
This task sets up watchers for file changes to re-run tasks.

    gulp.task 'watch', ['default', 'server'], ->
      gulp.watch 'bower.json', ['vendor']
      gulp.watch '@(app|test)/**/*.?(lit)coffee', ['lint', 'test']
      gulp.watch 'static/**', ['static']
      gulp.watch 'app/**/*.litcoffee', ['scripts']
      gulp.watch 'app/**/*.jade', ['templates', 'test']
      gulp.watch 'styles/**/*.scss', ['styles']
      livereload.listen basePath: buildDir


Clean Task
----------
We expose a simple clean task that just removes the build and bower dependency
directories.

    gulp.task 'clean', -> del [buildDir, bowerDir]


  <!-- Footnote Links -->
  [wiredep]: https://github.com/taptapship/wiredep
  [coffeelint]: http://www.coffeelint.org/
  [karma]: https://karma-runner.github.io/
