require "./test_helper"
balance = require "../src/crypto-balance"
_ = require("lodash")


describe "Asset Names", ->

  it "has the name DOGE", (done) ->
    balance("DDogepartyxxxxxxxxxxxxxxxxxxw1dfzr").then (result) ->
      expect(result[0].asset).to.be.eq "DOGE"
      done()

  it "has the name LTC", (done) ->
    balance("LNxtUEZ7Wmv8YsPaRV1f7pQBKXcKfVjUpe").then (result) ->
      expect(result[0].asset).to.be.eq "LTC"
      done()

  it "has the name SJCX", (done) ->
    balance("14wCap1sr7zvhDJQmoUoc1tvnLerFT2Jvi").then (result) ->
      sjcx = _.find(result, (item) -> item.asset.search(/sjcx/i) >= 0)
      expect(sjcx.asset).to.be.eq "SJCX"
      done()

  it "has the name XCP", (done) ->
    balance("15Rs7YLUP4NdZF37a4GEsiCxEwnAKHWeUd").then (result) ->
      xcp = _.find(result, (item) -> item.asset.search(/xcp$/i) >= 0)
      expect(xcp.asset).to.be.eq "XCP"
      done()

