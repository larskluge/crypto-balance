Promise = require("bluebird")
services = require('./services')


balance = (addr, callback) ->
  Promise
    .all [services.dogeparty(addr), services.chain_so(addr), services.counterparty(addr)]
    .reduce (a, b) ->
      a.concat b
    , []
    .filter (asset) ->
      asset.address == addr
    .then (assets) ->
      assets
    .nodeify callback


module.exports = balance

