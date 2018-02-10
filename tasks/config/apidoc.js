module.exports = function (grunt) {
  grunt.config.set('apidoc', {
    app: {
      src: "api/",
      dest: ".tmp/public/apidoc/",
      options: {
        debug: false
      }
    }
  });

  grunt.loadNpmTasks('grunt-apidoc');
};
