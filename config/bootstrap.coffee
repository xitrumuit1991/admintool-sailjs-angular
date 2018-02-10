module.exports.bootstrap = (cb) ->
  user.initUserAdminData()
  group.initGroupAdminData()
  cb();

