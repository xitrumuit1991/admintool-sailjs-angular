module.exports.connections = {
  //urlLinkApi : 'http://113.164.27.20:8000/api',
  urlLinkApi : 'http://203.205.37.249:8000/api',
  // urlLinkApi : 'http://analytic.sbd/api',
  localDiskDb: {
    adapter: 'sails-disk'
  },
  sqlServer: {
    adapter: "sails-mysql",
    host: "localhost",
    port: 3306,
    pool: true,
    connectionLimit: 32,
    waitForConnections: true,
    user: 'root',
    password: '',
    database: "sbd_admintool"
  },
};
