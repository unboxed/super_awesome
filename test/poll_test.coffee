chai = require 'chai'
expect = chai.expect

Poll = require '../lib/poll'

describe 'Poll.findByUuid', ->
  it 'returns undefined for a non existing poll', ->
    Poll.findByUuid '13d96a23-3b8c-4c51-8015-fdf4e632ab1e', (poll) ->
      expect(poll).to.eq(undefined)

  it 'returns undefined for an invalid uuid', ->
    Poll.findByUuid 'blahblah', (poll) ->
      expect(poll).to.eq(undefined)
