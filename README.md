# Introduction

`connect-less` is [Connect](http://www.senchalabs.org/connect/)
middleware that compiles [LESS](http://lesscss.org/) to CSS. Since
[express](http://expressjs.com) is built on top of Connect,
`connect-less` will allow you to compile LESS with expressjs.

# Installation

    npm install connect-less

# Usage

Example using express:

    less = require('connect-less')
    app = require('express').createServer()

    app.use("/main.css", less("path/to/main.less", {
      paths: ["path/to/other/less/files"]
    }));

    app.listen(80);

The middleware builder takes two arguments `source` and `options`

* `source`: The path to the main .less file to compile
* `options`: Object of options with the following keys
  * `paths`: Array of paths to .less files for `@import`s

If `options.paths` is not defined, it will default to the directory
containing the source file (`path.dirname(source)`).
