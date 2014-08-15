Promise = require("bluebird")
req = Promise.promisifyAll(require("request"))


# todo: find a better way
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0'


dogeparty = (addr) ->
  Promise
    .all [["XDP", "https://wallet.dogeparty.io/_api"], ["XDPTEST", "http://testnet.wallet.dogeparty.io/_t_api"]]
    .map (attrs) ->
      [token, url] = attrs
      req.postAsync(
        url: url
        json: true
        body:
          jsonrpc: "2.0"
          id: 0
          method: "proxy_to_counterpartyd"
          params:
            method: "get_balances"
            params:
              filters:
                field: "address"
                op: "=="
                value: addr
      )
        .spread (resp, json) ->
          if e = json.error
            throw new Error("#{e.message} (#{e.code}): #{JSON.stringify(e.data)}")
            []
          else
            json.result
        .map (item) ->
          {address: item.address, balance: item.quantity, token: "#{token}/#{item.asset}"}
    .reduce (item, merged) ->
      merged.concat item
    , []


module.exports = dogeparty

