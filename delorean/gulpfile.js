var gulp = require('gulp')
    , concat = require('gulp-concat');

gulp.task('default', function() {
    gulp.start('scripts');
});

gulp.task('scripts', function () {
    gulp.src(['./bower_components/*/dist/*.min.js' // jQuery, rangeslider
        , './bower_components/*/*min.js' // es6, fetch, underscore
        , './bower_components/*/build/*.min.js']) // stats, three
        .pipe(concat('all.js'))
        .pipe(gulp.dest('./dist/'));
});
