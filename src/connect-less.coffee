{render} = require 'less'
{readFile} = require 'fs'
{dirname} = require 'path'

module.exports = (source, options = {}) ->
  paths = options.paths or [dirname(source)]

  # Middleware
  (req, res, next) ->
    readFile source, (err, txt) ->
      render txt.toString(), {paths: paths}, (err, css) ->
        res.header 'Content-Type', 'text/css'
        res.send css

