(function() {
  var dirname, readFile, render;

  render = require('less').render;

  readFile = require('fs').readFile;

  dirname = require('path').dirname;

  module.exports = function(source, options) {
    var paths;
    if (options == null) options = {};
    if (!source) throw new Error('source less file path is required');
    paths = options.paths || [dirname(source)];
    return function(req, res, next) {
      return readFile(source, function(err, txt) {
        return render(txt.toString(), {
          paths: paths
        }, function(err, css) {
          res.writeHead(200, {
            'Content-Type': 'text/css',
            'Content-Length': css.length
          });
          return res.end(css);
        });
      });
    };
  };

}).call(this);
