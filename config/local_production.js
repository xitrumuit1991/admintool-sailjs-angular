module.exports = {
  port:8080,
  connections:{
    sqlServer:{
      adapter:"sails-mysql",
      host:"172.40.5.7",
      port:3306,
      pool:true,
      connectionLimit:32,
      waitForConnections:true,
      user:'root',
      password:'123456789',
      pass:'123456789',
      database:"sbd_admintool"
    }
  },
  session:{
    host: '172.40.5.7',
    port: 6379,
    pass: false,
    password: false,
    // ttl: 86400,
    db: 0,
    prefix: 'sbd:session:admintool:',
  }
};
