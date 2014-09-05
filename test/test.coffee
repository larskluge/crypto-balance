require "./test_helper"
balance = require "../src/crypto-balance"


describe "Balance", ->

  it "gets something", (done) ->
    balance("DP15mU18LLcLMpULSpFm5R77FYjsjjRCPu").then (result) ->
      expect(result).to.be.an "array"
      expect(result).to.not.be.empty
      done()

  it "returns the number of burned DOGE for Dogeparty", (done) ->
    balance("DDogepartyxxxxxxxxxxxxxxxxxxw1dfzr").then (result) ->
      expect(result).to.have.length(1)
      expect(result[0].asset).to.be.eq "DOGE"
      expect(result[0].quantity).to.be.eq "1831619391.01419473"
      expect(result[0].address).to.be.eq "DDogepartyxxxxxxxxxxxxxxxxxxw1dfzr"
      done()

