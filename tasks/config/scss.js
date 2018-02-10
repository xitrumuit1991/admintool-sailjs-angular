module.exports = function (grunt) {
  grunt.config.set('sass', {
    dev: {
      options: {
        'lineNumbers': true
      },
      files: [
        {
          expand: true,
          cwd: 'assets',
          src: ['**/*.scss', '!include/**', '!page/**' ],
          dest: '.tmp/public/',
          ext: '.css'
        },
        {
          expand: true,
          cwd: 'application',
          src: ['**/*.scss'],
          dest: '.tmp/public/styles',
          ext: '.css'
        }
      ]
    }
  });
  grunt.loadNpmTasks('grunt-contrib-sass');
};
