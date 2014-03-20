Bookshelf = require 'bookshelf'

Db = Bookshelf.initialize({
  client: 'pg',
  connection: {
    host     : '127.0.0.1',
    user     : 'henry.turner',
    password : '',
    database : 'super_awesome_test',
    charset  : 'utf8'
  }
})

module.exports = Db