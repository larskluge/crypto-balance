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
      if res.status == 'success'
        status: 'success'
        address: data.address
        quantity: data.confirmed_balance
        asset: data.network
      else
        if data?.address == 'A valid address is required'
          return # all good, this blockchain has another address format than requested
        else
          status: 'error'
          service: data.service
          message: 'TODO'
          raw: res
    .filter (item) -> !!item


module.exports = chain_so

