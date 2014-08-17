Promise = require("bluebird")
req = Promise.promisifyAll(require("request"))


counterparty = (addr) ->
  Promise
    .all [["XCP", "https://counterwallet.co/_api"], ["XCPTEST", "https://counterwallet.co/_t_api"]]
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
          json.result
        .map (item) ->
          {address: item.address, balance: item.quantity, token: "#{token}/#{item.asset}"}
    .reduce (item, merged) ->
      merged.concat item
    , []


module.exports = counterparty

