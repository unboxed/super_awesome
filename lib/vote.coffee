Db = require './db'

Vote = ->

  create = (params, callback) ->
    Db('votes').insert(params)
      .returning 'id'
      .then (id) ->
        callback id

  resultsData = (id, callback) ->
    Db.raw('select votes.value, count(votes.id) as cnt from votes where votes.poll_id='+ String(id) + ' group by votes.value order by cnt;')
      .then (resp) ->
        callback resp.rows

  {
    create: (params, callback) -> create(params, callback),
    resultsData: (uuid, callback) -> resultsData(uuid, callback)
  }

module.exports = Vote()