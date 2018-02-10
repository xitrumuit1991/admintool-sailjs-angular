/**
 * `watch`
 *
 * ---------------------------------------------------------------
 *
 * Run predefined tasks whenever watched file patterns are added, changed or deleted.
 *
 * Watch for changes on:
 * - files in the `assets` folder
 * - the `tasks/pipeline.js` file
 * and re-run the appropriate tasks.
 *
 * For usage docs see:
 *   https://github.com/gruntjs/grunt-contrib-watch
 *
 */
module.exports = function(grunt) {

  grunt.config.set('watch', {
    assets: {
      files: ['assets/**/*','application/**/*', 'tasks/pipeline.js', '!**/node_modules/**'],
      tasks: ['syncAssets' , 'linkAssets' ]
    },
    coffee: {
      files: ['application/**/*.coffee', 'tasks/pipeline.js', '!**/node_modules/**'],
      tasks: ['clean:coffee','coffee:dev', 'sails-linker:devJsJade']
    },
    jade: {
      files: ['application/**/*.jade', 'tasks/pipeline.js', '!**/node_modules/**'],
      tasks: ['clean:jade', 'jade:templates']
    },
    scss: {
      files: ['assets/styles/**/*.scss', 'tasks/pipeline.js', '!**/node_modules/**'],
      tasks: ['sass:dev']
    },
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
};
