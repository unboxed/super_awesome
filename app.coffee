http = require 'http'
express = require 'express'
topics = []

Poll = require './lib/poll'
Vote = require './lib/vote'

app = express()

PORT = 8124
LOCALHOST = "127.0.0.1"

# Express config 
app.use express.bodyParser()
app.engine 'jade', require('jade').__express
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'
app.use(express.static(__dirname + '/public'));

app.get '/polls/new', (req, res) -> 
  console.log "called #{req.method}: #{req.url}"
  res.render 'polls/new', {}


app.post '/polls/:uuid/choice', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  new Poll(uuid: req.params.uuid)
  .fetch()
  .then (poll) ->

    new Vote(poll_id: poll.get('id'), value: req.body.choice)
      .save()
      .then (vote) ->

        res.redirect '/polls/' + poll.get('uuid') + '/results'
        res.end()


app.post '/polls', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  new Poll({description: req.body.description})
    .save()
    .then (poll) ->

      new Poll(id: poll.get('id'))
        .fetch()
        .then (poll) ->

          res.redirect '/polls/'+poll.get('uuid')
          res.end()

app.get '/polls/:uuid', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  new Poll(uuid: req.params.uuid)
    .fetch()
    .then (poll) ->

      res.render 'polls/show', { description: poll.get('description'), uuid: poll.get('uuid') }

    .catch ->

      res.render 'not_found'


app.get '/polls/:uuid/results', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  new Poll(uuid: req.params.uuid)
    .fetch()
    .then (poll) ->

      qb = (new Vote).query()
      qb
        .where('votes.poll_id', '=', poll.get('id'))
        .groupBy('votes.value')
        .select('votes.value')
        .count('votes.id')
        .then (results) ->

          res.render 'polls/results', {poll_description: poll.get('description'), results: results}

app.get '/', (req, res) ->
  res.redirect '/polls/new'
 
app.listen PORT, LOCALHOST

console.log "Server running at #{LOCALHOST}, #{PORT}"

