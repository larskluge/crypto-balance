Promise = require("bluebird")
services = require('./services')
normalizeAssetName = require('./asset-names').normalize


balance = (addr, callback) ->

  Promise
    .settle(fn(addr) for s, fn of services)
    .timeout(20000)
    .cancellable()
    .map (pi) -> pi.isFulfilled() and pi.value()
    .filter (item) -> !!item
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

