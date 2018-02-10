module.exports.connections = {

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
