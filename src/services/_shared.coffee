Promise = require("bluebird")
_ = require('underscore')
req = Promise.promisifyAll(require("request"))


party = (addr, services) ->
  Promise
    .all services
    .map (attrs) ->
      [token, url] = attrs
      req.postAsync(
        url: url
        json: true
        body:
          jsonrpc: "2.0"
          id: 0
          method: "get_normalized_balances"
          params:
            addresses: [addr]
      )
        .spread (resp, json) ->
          json.result
        .map (item) ->
          tokenName = _([token, item.asset]).uniq().join('/')
          {address: item.address, balance: item.normalized_quantity, token: tokenName}
    .reduce (item, merged) ->
      merged.concat item
    , []


module.exports.party = party

