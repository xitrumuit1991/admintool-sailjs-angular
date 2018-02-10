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
      database:"sbd_admintool"
    },
  }
};
