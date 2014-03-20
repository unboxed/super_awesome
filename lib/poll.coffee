Db = require './db'
Vote = require './vote'

Poll = Db.Model.extend({

  tableName: 'polls',

  votes: ->
    return this.hasMany(Vote)

});

module.exports = Poll