Promise = require("bluebird")
req = Promise.promisifyAll(require("request"))


chain_so = (addr) ->
  Promise
    .all ['BTC', 'LTC', 'DOGE', 'BTCTEST', 'LTCTEST', 'DOGETEST']
    .map (network) ->
      url = "https://chain.so/api/v2/get_address_balance/#{network}/#{addr}"
      req.getAsync(url)
        .spread (resp, body) ->
          JSON.parse(body)
    .filter (res) ->
      res.status == 'success'
    .map (res) ->
      data = res.data
      {address: data.address, balance: data.confirmed_balance, token: data.network}


module.exports = chain_so

