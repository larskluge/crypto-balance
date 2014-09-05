Promise = require("bluebird")
req = Promise.promisifyAll(require("request"))
_ = require("underscore")


chain_so = (addr) ->
  Promise
    .all ['BTC', 'LTC', 'DOGE', 'BTCTEST', 'LTCTEST', 'DOGETEST']
    .map (network) ->
      url = "https://chain.so/api/v2/get_address_balance/#{network}/#{addr}"
      req.getAsync(url)
        .spread (resp, body) ->
          json = JSON.parse(body)
          _(json.data).extend service: url
          json
    .map (res) ->
      data = res.data
      item = success: res.status == 'success'
      if item.success
        item.status = 'success'
        item.address = data.address
        item.quantity = data.confirmed_balance
        item.asset = data.network
      else
        if data?.address == 'A valid address is required'
          return # all good, this blockchain has another address format than requested
        else
          item.status = 'warning'
          item.service = data.service
          item.message = 'TODO'
          item.raw = res
      item
    .filter (item) -> !!item


module.exports = chain_so

