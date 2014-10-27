ETHER_FOR_BTC = 2000
DECREASE_AMOUNT_PER_DAY = 30
MIN_ETH_FOR_BTC = 1337.07714935
FUNDRAISING_ADDRESS = "36PrZ1KHYMpqSyAQXSG8VwbUiq2EogxLo2"
SATOSHIS_PER_BTC = 1e8
DECREASE_AFTER = 14


Promise = require("bluebird")
req = Promise.promisifyAll(require("request"))
bs58check = require 'bs58check'



base58checkEncode = (x, vbyte) ->
  vbyte = vbyte or 0
  payload = new Buffer "00#{x}", 'hex'
  bs58check.encode payload


dhms = (t) ->
  cd = 24 * 60 * 60 * 1000
  ch = 60 * 60 * 1000
  cm = 60 * 1000

  d = Math.floor(t / cd)
  h = Math.floor((t - d * cd) / ch)
  m = Math.floor((t - d * cd - h * ch) / cm)
  s = Math.round((t - d * cd - h * ch - m * cm) / 1000)

  days: d
  hours: h
  minutes: m
  seconds: s


balanceByDate = (value, date) ->
  delta = dhms((date - 1406066400) * 1000)
  price = ETHER_FOR_BTC
  return 0  if delta.days < 0
  price = ETHER_FOR_BTC - (delta.days - DECREASE_AFTER + 1) * DECREASE_AMOUNT_PER_DAY  if delta.days >= DECREASE_AFTER
  price = Math.max(price, MIN_ETH_FOR_BTC)
  total = value * price


class ReqError extends Error
  constructor: (resp) ->
    @name = "ReqError"
    if resp.body.data.address.search /valid address.*required/i >= 0
      @message = "Invalid address"
    else
      @message = "Some API error occured"
    @resp = resp


ether = (addr) ->
  btcaddr = base58checkEncode(addr, 0)

  req.getAsync "https://chain.so/api/v2/get_tx_unspent/BTC/#{btcaddr}", json: true
    .spread (resp, json) ->
      if json.status == 'success'
        json.data.txs
      else
        throw new ReqError(resp)
    .map (utx) ->
      req.getAsync "https://chain.so/api/v2/get_tx/BTC/#{utx.txid}", json: true
        .spread (resp, json) ->
          out = json.data.outputs[0]
          if out.address is FUNDRAISING_ADDRESS
            btc = parseFloat(out.value) + (30000 / SATOSHIS_PER_BTC)
            eth = balanceByDate(btc, json.data.time)
          else
            throw "There was a problem fetching your ether balance. Please ensure you have entered the correct ether address"
    .reduce (a, b) -> a + b
    .then (eth) ->
      status: "success"
      service: "Ethereum"
      address: addr
      quantity: eth.toFixed(8)
      asset: "ETH"
    .catch ReqError, (e) ->
      unless e.message == 'Invalid address'
        status: 'error'
        service: "Ethereum"
        message: e.message
        raw: e.resp


module.exports = ether

