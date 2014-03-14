http = require 'http'
express = require 'express'
topics = []
{ new_topic: new_topic_template, show_topic: show_topic_template } = require './templates'
 
app = express()

PORT = 8124
LOCALHOST = "127.0.0.1"
HTTP_SUCCESS = 200
HTTP_REDIRECT = 301
 
app.use express.bodyParser()

app.get '/teardown', (req, res) ->
  console.log "called #{req.method}: #{req.url}"
  topics = []
  res.end()

app.get '/topic/new', (req, res) -> 
  console.log "called #{req.method}: #{req.url}"
  res.writeHead HTTP_SUCCESS, 
    'Content-Type': 'text/html'
  res.end new_topic_template()

app.post '/topic', (req, res) ->
  console.log "called #{req.method}: #{req.url}"
  topics.push req.body.description
  res.writeHead HTTP_REDIRECT,
    'Location': "/topic/1"
  res.end()

app.get '/topic/:id', (req, res) ->
  console.log "called #{req.method}: #{req.url}"
  id = (parseInt req.params.id) - 1
  res.writeHead HTTP_SUCCESS, 
    'Content-Type': 'text/html'
  res.end show_topic_template(topics[id], id)
 
app.listen PORT, LOCALHOST

console.log "Server running at #{LOCALHOST}, #{PORT}"

