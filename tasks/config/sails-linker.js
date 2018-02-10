var files = require('../pipeline').files;
var js = files.js;
var css = files.css;
var template = files.template;
var templateProd = files.templateProd;
var _ = require('lodash');
module.exports = function (grunt) {
  grunt.config.set('sails-linker', {
    devJsJade: {
      options: {
        startTag: '// SCRIPTS',
        endTag: '// SCRIPTS END',
        fileTmpl: 'script(src="%s")',
        appRoot: '.tmp/public'
      },
      files: template.js
    },
    prodJsJade: {
      options: {
        startTag: '// SCRIPTS',
        endTag: '// SCRIPTS END',
        fileTmpl: 'script(src="%s?v=<%- Date.now() %>")',
        appRoot: '.tmp/public'
      },
      files: templateProd.js
    },
    devStylesJade: {
      options: {
        startTag: '// STYLES',
        endTag: '// STYLES END',
        fileTmpl: 'link(rel="stylesheet", href="%s")',
        appRoot: '.tmp/public'
      },

      files: template.css
    },

    prodStylesJade: {
      options: {
        startTag: '// STYLES',
        endTag: '// STYLES END',
        fileTmpl: 'link(rel="stylesheet", href="%s?v=<%- Date.now() %>")',
        appRoot: '.tmp/public'
      },
      files: templateProd.css
    }

  });
  grunt.loadNpmTasks('grunt-sails-linker');
};
