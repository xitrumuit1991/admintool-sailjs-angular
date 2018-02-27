var cssFilesToInject = [
  'css/**/*.css',
  'styles/**/*.css'
];

var jsFilesToInject = [
  'js/lib/jquery.min.js',
  'js/lib/jquery-ui-1.10.3.js',
  'js/lib/bootstrap.js',
  'js/lib/async.js',
  'js/lib/lodash.js',
  'js/lib/lodashmixins.js',
  'js/lib/moment.js',
  'js/lib/chart.js',
  'js/lib/chartjs-plugin-zoom.js',
  'js/lib/lib_angular/angular.js',
  'js/lib/lib_angular/**/*.js',
  'js/lib/**/*.js',
  'js/plugins/sparkline/jquery.sparkline.min.js',
  'js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js',
  'js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js',
  'js/plugins/fullcalendar/fullcalendar.min.js',
  'js/plugins/jqueryKnob/jquery.knob.js',
  'js/plugins/bootstrap-daterangepicker/bootstrap-daterangepicker.js',
  'js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js',
  'js/plugins/iCheck/icheck.min.js',
  'js/z_AdminLTE/app.js',
  'js/z_AdminLTE/dashboard.js',
];

var templateFilesToInject = [
  'templates/**/*.html'
];

var homeJsFile = [
  'application/app.js',
  'application/appCtrl.js',
  'application/master/index.js',
  'application/master/directive/**/*.js',
  'application/master/factory/**/*.js',
  'application/master/filter/**/*.js',
  'application/master/service/**/*.js',
];

var application = [
  'libary',
  'home',
  'admin',
  'analytic',
];

var files = {
  js: {},
  css: {},
  templateProd: {
    js: {},
    css: {}
  },
  template: {
    js: {},
    css: {}
  }
};

var tmpPath = '.tmp/public/';

application.map(function (app) {
  switch (app) {
    case 'libary':
      files.js[app] = jsFilesToInject;
      files.css[app] = cssFilesToInject;
      break;
    case 'home':
      files.js[app] = homeJsFile;
      files.css[app] = cssFilesToInject;
      break;
    default:
      files.js[app] = [
        'application/app.js',
        'application/appCtrl.js',
        'application/' + app + '/index.js',
        'application/' + app + '/**/*.js',
        'application/' + app + '/directive/**/*.js',
        'application/' + app + '/factory/**/*.js',
        'application/' + app + '/filter/**/*.js',
        'application/' + app + '/service/**/*.js',
        'application/master/directive/**/*.js',
        'application/master/factory/**/*.js',
        'application/master/filter/**/*.js',
        'application/master/service/**/*.js',
      ];
      files.css[app] = cssFilesToInject;
  }

  files.js[app] = files.js[app].map(function (jsPath) {
    if (jsPath[0] === '!') {
      return require('path').join('!' + tmpPath, jsPath.substr(1));
    }
    return require('path').join(tmpPath, jsPath);
  });

  files.css[app] = files.css[app].map(function (cssPath) {
    if (cssPath[0] === '!') {
      return require('path').join('!' + tmpPath, cssPath.substr(1));
    }
    return require('path').join(tmpPath, cssPath);
  });
  switch (app) {
    case 'libary':
      files.template.js['views/include/script.jade'] = files.js[app];
      files.template.css['views/include/style.jade'] = files.css[app];
      break;
    case 'home':
      files.template.js['views/home.jade'] = files.js[app];
      files.templateProd.js['views/home.jade'] = ['.tmp/public/production_' + app + '.min.js'];
      break;
    default :
      files.template.js['views/application/' + app + '.jade'] = files.js[app];
      files.templateProd.js['views/application/' + app + '.jade'] = ['.tmp/public/production_' + app + '.min.js'];
  }
});
module.exports.files = files;

