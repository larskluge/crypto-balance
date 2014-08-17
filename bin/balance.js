#!/usr/bin/env node
// vim: set ft=js

var path = require('path');
var fs   = require('fs');
var lib  = path.join(path.dirname(fs.realpathSync(__filename)), '../lib');

require(lib + '/command').run();

