Poll = require './poll'
Vote = require './vote'

new Poll()
  .fetch()
  .then (model) ->
    console.log model.get('description')