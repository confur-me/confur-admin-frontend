'use strict';

/**
 * Dependencies
 */
var path         = require('path');
var gulp         = require('gulp');
var stylus       = require('gulp-stylus');
var bootstrap    = require('bootstrap-styl');
var coffee       = require('gulp-coffee');
var gutil        = require('gulp-util');
var gulpJade     = require('gulp-jade');
var jade         = require('jade');
var autoprefixer = require('gulp-autoprefixer');
var sourcemaps   = require('gulp-sourcemaps');
var watch        = require('gulp-watch');
var browserify   = require('gulp-browserify');
var rename       = require('gulp-rename');
var pkg          = require('./package');
var dependencies = Object.keys(pkg.dependencies);
var source       = require('vinyl-source-stream');
var buffer       = require('vinyl-buffer');

var appCss          = './app/styles/application.styl';
var cssGlob         = './app/styles/**/*.styl';
var appJs           = './app/js/application.coffee';
var jsGlob          = './app/js/**/*.coffee';
var jadeGlob        = './app/views/**/*.jade';
var outputAssetsDir = './public/assets';
var outputTemplatesDir = './public/templates';

var paths = []
  .concat(path.resolve('./app/js'))
  .concat(path.resolve('./node_modules'));

var gulp_log = function(e, p) {
  console.log('File ' + p + ' was ' + e + ', running tasks...');
}

gulp.task('app:js', function() {
  return gulp.src(appJs, { read: false })
    .pipe(sourcemaps.init())
    //.pipe(coffee({bare: true}))
    .pipe(browserify({
      //insertGlobals : true,
      transform: ['coffeeify'],
      extensions: ['.coffee', '.js'],
      paths: paths,
      external: dependencies
    }))
    //.pipe(rev())
    .pipe(rename('application.js'))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(outputAssetsDir))
  ;
});

gulp.task('vendor:js', function() {
  return gulp.src('./app/js/vendor.js', { read: false})
    .pipe(browserify({
      paths: paths,
      require: dependencies,
      debug: true,
      cache: {},
      packageCache: {},
      fullPaths: true
    }))
    .pipe(gulp.dest(outputAssetsDir))
  ;
});

gulp.task('css', function() {
  return gulp.src(appCss)
    .pipe(sourcemaps.init())
    .pipe(stylus({
        use: bootstrap()
        //,
        //paths: paths.styles
      }))
    .pipe(autoprefixer({
        cascade: false
      }))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(outputAssetsDir))
  ;
});

gulp.task('jade', function () {
  return gulp.src(jadeGlob)
    .pipe(gulpJade({
      jade: jade,
      pretty: true
    }))
    .pipe(gulp.dest(outputTemplatesDir))
});

gulp.task('jade', function () {
  return gulp.src(jadeGlob)
    .pipe(gulpJade({
      jade: jade,
      pretty: true
    }))
    .pipe(gulp.dest(outputTemplatesDir))
});

// watch for css
gulp.task('watch-css', function() {
  gulp.watch(cssGlob,
    ['css']
  ).on('change', function(event) {
    gulp_log(event.type, event.path);
  });
});

// watch for js
gulp.task('watch-js', function() {
  gulp.watch(jsGlob,
    ['app:js']
  ).on('change', function(event) {
    gulp_log(event.type, event.path);
  });
});

// watch for jade
gulp.task('watch-jade', function() {
  gulp.watch(jadeGlob,
    ['jade']
  ).on('change', function(event) {
    gulp_log(event.type, event.path);
  });
});

gulp.task('default', ['app:js', 'vendor:js', 'css', 'jade']);
gulp.task('watch', ['default', 'watch-js', 'watch-css', 'watch-jade']);
