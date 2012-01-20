connect_less = require '../'
less = require 'less'
connect = require 'connect'
request = require './support/request'
{dirname} = require 'path'
{readFile} = require 'fs'
should = require 'should'

FIXTURE =
  simple: "#{__dirname}/fixtures/less/simple.less"

describe 'connect-lesscss', ->

  it 'should be a function', ->
    connect_less.should.be.a('function')

  it 'should require a path', ->
    (->connect_less()).should.throw()

  describe 'mounted without options', ->
    response = null

    before (done) ->
      app = connect.createServer()
      app.use '/main.css', connect_less(FIXTURE.simple)
      request(app)
        .request('get', '/main.css')
        .end (res) ->
          response = res
          done()

    it 'should have a text/css content type', ->
      response.headers['content-type'].should.equal 'text/css'

    it 'should send the correct content-length', ->
      response.headers['content-length'].should.eql response.body.length.toString()

    it 'should send a 200 response', ->
      response.statusCode.should.equal 200

    it 'should send the correct CSS', (done) ->
      renderLess FIXTURE.simple, paths: [dirname(FIXTURE.simple)], (css) ->
        response.body.should.equal css 
        done()


# Helpers
renderLess = (filename, options, fn) ->
  readFile filename, (err, text) ->
    should.not.exist err
    less.render text.toString(), options, (err, css) ->
      should.not.exist err
      fn(css)

