/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes map URLs to views and controllers.
 *
 * If Sails receives a URL that doesn't match any of the routes below,
 * it will check for matching files (images, scripts, stylesheets, etc.)
 * in your assets directory.  e.g. `http://localhost:1337/images/foo.jpg`
 * might match an image file: `/assets/images/foo.jpg`
 *
 * Finally, if those don't match either, the default 404 handler is triggered.
 * See `api/responses/notFound.js` to adjust your app's 404 logic.
 *
 * Note: Sails doesn't ACTUALLY serve stuff from `assets`-- the default Gruntfile in Sails copies
 * flat files from `assets` to `.tmp/public`.  This allows you to do things like compile LESS or
 * CoffeeScript for the front-end.
 *
 * For more information on configuring custom routes, check out:
 * http://sailsjs.org/#!/documentation/concepts/Routes/RouteTargetSyntax.html
 */

module.exports.routes = {
  '/': 'admin/pageController.home', //home page admin
  'GET /health_check': 'admin/healthCheckController.index',
  'GET /template': 'admin/pageController.template',

  'GET /login': 'admin/authController.login', //login page
  'GET /logout': 'admin/authController.logout',
  'POST /auth': 'admin/authController.auth', //submit login page
  'GET /auth': 'admin/authController.auth',



  //Page module
  'GET /admin': 'admin/pageController.admin',
  'GET /analytic': 'admin/pageController.analytic',


  //Analytic
  //content-report
  'POST /analytic/content-report/top-content-table' : 'analytic/contentReportController.topContentTable',
  'POST /analytic/content-report/top-content-chart' : 'analytic/contentReportController.topContentChart',
  'POST /analytic/content-report/top-content-summary' : 'analytic/contentReportController.topContentSummary',
  'POST /analytic/content-report/get-content-by-ids' : 'analytic/contentReportController.getContentByIds',

  //system-report
  'POST /analytic/system-report/platform-table' : 'analytic/systemReportController.platformTable',
  'POST /analytic/system-report/platform-chart' : 'analytic/systemReportController.platformChart',
  'POST /analytic/system-report/platform-summary' : 'analytic/systemReportController.platformSummary',

  'POST /analytic/system-report/os-table' : 'analytic/systemReportController.osTable',
  'POST /analytic/system-report/os-chart' : 'analytic/systemReportController.osChart',
  'POST /analytic/system-report/os-summary' : 'analytic/systemReportController.osSummary',

  'POST /analytic/system-report/browser-table' : 'analytic/systemReportController.browserTable',
  'POST /analytic/system-report/browser-chart' : 'analytic/systemReportController.browserChart',
  'POST /analytic/system-report/browser-summary' : 'analytic/systemReportController.browserSummary',
};
