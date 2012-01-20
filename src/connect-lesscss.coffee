{render} = require 'less'
{readFile} = require 'fs'
{dirname} = require 'path'

module.exports = (source, options = {}) ->
  unless source
    throw new Error 'source less file path is required'
  paths = options.paths or [dirname(source)]

  # Middleware
  (req, res, next) ->
    readFile source, (err, txt) ->
      render txt.toString(), {paths: paths}, (err, css) ->
        res.writeHead 200, 
          'Content-Type' : 'text/css'
          'Content-Length': css.length
        res.end css

