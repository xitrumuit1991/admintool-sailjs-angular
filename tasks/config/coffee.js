module.exports = function (grunt) {
  grunt.config.set('coffee',{
    dev:{
      options:{
        bare:true,
        sourceMap:false,
        sourceRoot:'./'
      },
      files:[{
        expand:true,
        cwd:'assets/js/',
        src:['**/*.coffee'],
        dest:'.tmp/public/js/',
        ext:'.js'
      },
      {
        expand:true,
        cwd:'application/',
        src:['**/*.coffee'],
        dest:'.tmp/public/application/',
        ext:'.js'
      }]
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
};
