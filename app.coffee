http = require 'http'
express = require 'express'
topics = []
{ new_topic: new_topic_template, show_topic: show_topic_template } = require './templates'
 
app = express()

PORT = 8124
LOCALHOST = "127.0.0.1"
HTTP_SUCCESS = 200
HTTP_REDIRECT = 301

# Express config 
app.use express.bodyParser()
app.engine 'jade', require('jade').__express
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'

app.get '/teardown', (req, res) ->
  console.log "called #{req.method}: #{req.url}"
  topics = []
  res.end("Success")

app.get '/topic/new', (req, res) -> 
  console.log "called #{req.method}: #{req.url}"
  res.render 'new_topic', {}
  # res.writeHead HTTP_SUCCESS, 
  #   'Content-Type': 'text/html'
  # res.end new_topic_template()

app.post '/topic/:id/choice', (req, res) ->
  console.log "called #{req.method}: #{req.url}"
  id = (parseInt req.params.id) - 1

  if !topics[id].choices?
    topics[id].choices = []
  
  topics[id].choices.push req.body.choice

  res.writeHead HTTP_REDIRECT,
    'Location': "/topic/1/result"
  res.end()

app.post '/topic', (req, res) ->
  console.log "called #{req.method}: #{req.url}"
  topics.push {description: req.body.description}
  res.writeHead HTTP_REDIRECT,
    'Location': "/topic/1"
  res.end()

app.get '/topic/:id', (req, res) ->
  console.log "called #{req.method}: #{req.url}"
  id = (parseInt req.params.id) - 1
  if topics[id]?
    res.render 'show_topic', { description: topics[id].description, id: (id + 1) }
  else
    res.render 'topic_not_found', {}

app.get '/topic/:id/result', (req, res) ->
  console.log "called #{req.method}: #{req.url}"
  id = (parseInt req.params.id) - 1

  results = {}

  for choice in topics[id].choices
    if results[choice]?
      ++results[choice]
    else
      results[choice] = 1

  res.render 'show_topic_result', {results: results}

  # res.writeHead HTTP_SUCCESS, 
  #   'Content-Type': 'text/html'
  # res.end show_topic_template(topics[id], id)
 
app.listen PORT, LOCALHOST

console.log "Server running at #{LOCALHOST}, #{PORT}"

