Db = require './db'

Vote = Db.Model.extend({
  tableName: 'votes'
});

module.exports = Vote