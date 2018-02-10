module.exports = function (grunt) {
  grunt.config.set('jade', {
    templates: {
      options: {
        pretty: false
      },
      files: [
        {
          expand: true,
          cwd: 'application/',
          src: ['**/*.jade'],
          dest: '.tmp/public/template',
          ext: '.html'
        },
        {
          expand: true,
          cwd: 'views/application',
          src: ['modulePage.jade'],
          dest: '.tmp/public/template',
          ext: '.html'
        }
      ]
    }
  });
  grunt.loadNpmTasks('grunt-contrib-jade');
};
