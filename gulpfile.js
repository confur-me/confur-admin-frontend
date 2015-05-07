'use strict';

/**
 * Dependencies
 */
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

var cssGlob = './app/stylesheets/application.styl';
var jsGlob = './app/javascripts/application.coffee';
var jadeGlob = './app/views/**/*.jade';

gulp.task('js', function() {
  return gulp.src(jsGlob)
    .pipe(sourcemaps.init())
    .pipe(coffee({bare: true}))
    //.pipe(rev())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('public/assets'))
  ;
});

gulp.task('css', function() {
  return gulp.src(cssGlob)
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
    .pipe(gulp.dest('public/assets'))
  ;
});

gulp.task('jade', function () {
  return gulp.src(jadeGlob)
    .pipe(gulpJade({
      jade: jade,
      pretty: true
    }))
    .pipe(gulp.dest('public/templates'))
});

// watch for css
gulp.task('watch-css', function() {
  gulp.watch(cssGlob,
    ['css']
  ).on('change', function(event) {
    console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
  });
});

// watch for js
gulp.task('watch-js', function() {
  gulp.watch(jsGlob,
    ['js']
  ).on('change', function(event) {
    console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
  });
});

// watch for jade
gulp.task('watch-jade', function() {
  gulp.watch(jadeGlob,
    ['jade']
  ).on('change', function(event) {
    console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
  });
});

gulp.task('default', ['js', 'css', 'jade']);
gulp.task('watch', ['watch-js', 'watch-css', 'watch-jade']);
