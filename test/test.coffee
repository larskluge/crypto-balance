require "./test_helper"
balance = require "../src/crypto-balance"
_ = require("underscore")


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

  it "has a custom Dogeparty asset", (done) ->
    balance("DCt8sxHX634ghqdDhWFtCPQUyZ3TEfLBCo").then (result) ->
      expect(result).to.not.be.empty
      dp = _.find(result, (item) -> item.asset == "XDP/DOGEPARTY")
      expect(dp).to.exist
      expect(dp.quantity).to.be.eq "1.00000000"
      done()

  it "has a MSC balance", (done) ->
    balance("1Po1oWkD2LmodfkBYiAktwh76vkF93LKnh").then (result) ->
      msc = _.find(result, (item) -> item.asset == "MSC")
      expect(msc).to.exist
      expect(msc.quantity).to.be.eq "1738.58121469"
      done()

  it "has a MAID balance", (done) ->
    balance("1madYsPmALf1TCo1qttumTH7Hbbro5uQD").then (result) ->
      maid = _.find(result, (item) -> item.asset == "MAID")
      expect(maid).to.exist
      expect(maid.quantity).to.be.eq "47600.00000000"
      done()

  it "has a ETH balance", (done) ->
    balance("1ebacb7844fdc322f805904fbf1962802db1537c").then (result) ->
      eth = _.find(result, (item) -> item.asset == "ETH")
      expect(eth).to.exist
      expect(eth.quantity).to.be.eq "10000.00000000"
      done()

  it "handles failing requests to one service correctly", (done) ->
    balance("DDAa254Jf99rLzmGe4wA3Shr7MaYBHDd1b").then (result) ->
      expect(result).to.have.length(2)
      success = _.find(result, (item) -> item.status == "success")
      expect(success).to.exist

      error = _.find(result, (item) -> item.status == "error")
      expect(error).to.exist
      expect(error.service).to.be.eq "https://wallet.dogeparty.io/_api"
      expect(error.message).to.be.eq "Server error. Code: -32000. Got call_jsonrpc_api request error: [Errno 111] Connection refused"
      done()

  it "handles counterparty testnet failure", (done) ->
    balance("13Dk4GmTdYfEjouL1x25PE5ztCMoVv6ipv").then (result) ->
      expect(result).to.have.length(2)
      error = _.find(result, (item) -> item.status == "error")
      expect(error).to.exist
      expect(error.service).to.be.eq "https://counterwallet.io/_t_api"
      expect(error.message).to.be.eq "Server error. Code: -32000. Server is not caught up. Please try again later."
      done()

