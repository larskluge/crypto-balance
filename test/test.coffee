require "./test_helper"
balance = require "../src/crypto-balance"


describe "Balance", ->

  it "gets the balance", (done) ->
    balance("DP15mU18LLcLMpULSpFm5R77FYjsjjRCPu").then (result) ->
      expect(result).to.be.an "array"
      expect(result).to.not.be.empty
      done()

