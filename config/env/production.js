module.exports = {
  port:8080,
  connections:{
    sqlServer:{
      adapter:"sails-mysql",
      host:"localhost",
      port:3306,
      pool:true,
      connectionLimit:32,
      waitForConnections:true,
      user:'root',
      password:'',
      pass:'',
      database:"sbd_admintool"
    }
  },
  session:{
    host: 'localhost',
    port: 6379,
    pass: false,
    password: false,
    // ttl: 86400,
    db: 0,
    prefix: 'sbd:session:admintool:',
  }
};
