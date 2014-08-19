Promise = require("bluebird")
_ = require('underscore')
req = Promise.promisifyAll(require("request"))

params = (url, addr) ->
  url: url
  json: true
  body:
    jsonrpc: "2.0"
    id: 0
    method: "get_normalized_balances"
    params:
      addresses: [addr]

party = (addr, services) ->
  Promise
    .all services
    .map (attrs) ->
      [token, url] = attrs
      req.postAsync(params url, addr)
        .spread (resp, json) ->
          json.result
        .map (item) ->
          tokenName = _([token, item.asset]).uniq().join('/')
          address: item.address
          balance: item.normalized_quantity
          token: tokenName
    .reduce (item, merged) ->
      merged.concat item
    , []


module.exports.party = party

