Promise = require("bluebird")
services = require('./services')
normalizeAssetName = require('./asset-names').normalize


balance = (addr, callback) ->
  Promise
    .all [services.dogeparty(addr), services.chain_so(addr), services.counterparty(addr)]
    .reduce (a, b) ->
      a.concat b
    , []
    .filter (asset) ->
      !asset.address or asset.address == addr
    .map (item) ->
      if item.address
        item.asset = normalizeAssetName(item.asset)
      item
    .nodeify callback


module.exports = balance

