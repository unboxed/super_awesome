Db = require './db'

Poll = ->

  findByUuid = (uuid, callback) ->
    Db.transaction( (t) ->
      Db('polls')
        .where({uuid: uuid})
        .select()
        .then (poll) ->
          callback poll[0]
        .then(t.commit, t.rollback)
      ).then(
        (-> ),
        (-> undefined)
      )

  create = (description, callback) ->
    Db('polls').insert({description: description})
      .returning 'uuid'
      .then (uuid) ->
        callback uuid

  {
    findByUuid: (uuid, callback) -> findByUuid(uuid, callback),
    create: (description, callback) -> create(description, callback)
  }

module.exports = Poll()