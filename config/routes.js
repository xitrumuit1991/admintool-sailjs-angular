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
  'POST /analytic/content-report/top-content-table' : 'analytic/contentReportController.topContentTable'


  /***************************************************************************
  *                                                                          *
  * Custom routes here...                                                    *
  *                                                                          *
  * If a request to a URL doesn't match any of the custom routes above, it   *
  * is matched against Sails route blueprints. See `config/blueprints.js`    *
  * for configuration options and examples.                                  *
  *                                                                          *
  ***************************************************************************/

};
