chai = require 'chai'
GLOBAL.expect = chai.expect
chai.config.includeStack = true

# VCRs with Replay
Replay = require "replay"
Replay.fixtures = "#{__dirname}/fixtures/replay"

