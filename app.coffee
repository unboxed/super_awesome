http = require 'http'
express = require 'express'

Poll = require './lib/poll'
Vote = require './lib/vote'

app = express()

PORT = 8124

# Express config 
app.use express.bodyParser()
app.engine 'jade', require('jade').__express
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'
app.use(express.static(__dirname + '/public'));

app.get '/polls/new', (req, res) -> 
  console.log "called #{req.method}: #{req.url}"
  res.render 'polls/new', {}


app.post '/polls/:uuid/votes', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  Poll.findByUuid req.params.uuid, (poll) ->
    Vote.create {poll_id: poll.id, value: req.body.choice}, (vote) ->
      res.redirect '/polls/' + poll.uuid + '/results'


app.post '/polls', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  Poll.create req.body.description, (uuid) ->
    res.redirect '/polls/' + uuid


app.get '/polls/:uuid', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  Poll.findByUuid req.params.uuid, (poll) ->
    if(typeof(poll) == 'undefined')
      res.end 'Not Found'
    else
      res.render 'polls/show', { description: poll.description, uuid: poll.uuid }


app.get '/polls/:uuid/results.json', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  Poll.findByUuid req.params.uuid, (poll) ->
    Vote.resultsData poll.id, (results) ->

      data = {
        labels : results.map (elem) -> elem.val
        datasets : [
          {
            data : results.map (elem) -> elem.cnt
          }
        ]
      }

      res.set 'Content-Type', 'application/json'
      res.send data
      res.end

app.get '/polls/:uuid/results', (req, res) ->
  console.log "called #{req.method}: #{req.url}"

  Poll.findByUuid req.params.uuid, (poll) ->
    res.render 'polls/results', { poll_description: poll.description }


app.get '/', (req, res) ->
  res.redirect '/polls/new'
 
port = process.env.PORT || PORT

app.listen(port)

console.log "Server running at #{port}"
