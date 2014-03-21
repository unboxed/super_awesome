Knex = require 'knex'
database_config = require '../config/database'

Db = Knex.initialize(database_config)

module.exports = Db