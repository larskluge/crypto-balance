GLOBAL.expect = require("chai").expect

# VCRs with Replay
Replay = require "replay"
Replay.fixtures = "#{__dirname}/fixtures/replay"
