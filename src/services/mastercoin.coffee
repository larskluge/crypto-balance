Promise = require("bluebird")
req = Promise.promisifyAll(require("request"))
_ = require("underscore")


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
      if item.symbol == "BTC"
        return

      quantity = if item.divisible then item.value * 0.00000001 else item.value
      asset = "MSC/#{item.symbol}"

      status: "success"
      service: url
      address: addr
      quantity: quantity
      asset: asset
    .filter (item) -> !!item


module.exports = msc

