module.exports.policies = {
  "*": ["sessionAuth", "checkPermission"],
  "admin/healthCheckController": {  "*": true},

  //module page
  'admin/pageController': {
    'home': true,
    'template' : true,
    '*': ['sessionAuth'],
  },

  //login, logout, auth
  'admin/authController': { "*": true},

  //admin module
  'admin/groupController': {
    '*': ['sessionAuth','checkPermission'],
    'find':true,
    'findOne':true,
  },
  'admin/userController': {
    '*': ['sessionAuth', 'checkPermission'],
    'find':true,
    'findOne':true,
    'userprofile':true,
  },

  //analytic module
  'analytic/contentReportController': {
    '*': ['sessionAuth', 'checkPermission'],
  },
};
