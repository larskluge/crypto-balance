Promise = require("bluebird")
req = Promise.promisifyAll(require("request"))
_ = require("lodash")


msc = (addr) ->
  url = "https://www.omniwallet.org/v1/address/addr/"
  opts = url: url, json: true, form: addr: addr

  req.postAsync(opts)
    .spread (resp, json) ->
      if resp.statusCode in [200..299] and json.address == addr and _.isArray(json.balance)
        json.balance
      else
        status: "error", service: url, message: "Unknown", raw: resp
    .map (item) ->
      return if item.symbol == "BTC"

      quantity = parseInt(item.value, 10)
      if item.divisible
        quantity *= 0.00000001

      asset = "MSC/#{item.symbol}"

      status: "success"
      service: url
      address: addr
      quantity: quantity.toFixed(8)
      asset: asset
    .filter (item) -> !!item


module.exports = msc

