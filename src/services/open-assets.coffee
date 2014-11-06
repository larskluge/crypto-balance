Promise = require("bluebird")
req = Promise.promisify(require("request"))
_ = require("lodash")
InvalidResponseError = require("../errors").InvalidResponseError


oa = (addr) ->
  url = "https://api.coinprism.com/v1/addresses/#{addr}"

  req(url, json: true)
    .timeout(10000)
    .cancellable()
    .spread (resp, json) ->
      if resp.statusCode in [200..299] and json.address == addr and _.isArray(json.assets)
        json.assets
      else
        if _.isObject(json) and json.Message == "Error" and json.ErrorCode == "InvalidAddress"
          []
        else
          throw new InvalidResponseError service: url, response: resp
    .map (asset) ->
      assetUrl = "https://api.coinprism.com/v1/assets/#{asset.address}"
      req(assetUrl, json: true)
        .timeout(10000)
        .cancellable()
        .spread (resp, json) ->
          if resp.statusCode in [200..299] and json.asset_address == asset.address
            _.merge asset, symbol: json.name_short, divisibility: json.divisibility
          else
            throw new InvalidResponseError service: url, response: resp
    .map (asset) ->
      balance = parseInt(asset.balance, 10)
      quantity = balance / (10 ** asset.divisibility)

      status: "success"
      service: url
      address: addr
      quantity: quantity.toFixed(8)
      asset: "OA/#{asset.symbol.toUpperCase()}"

    .catch Promise.TimeoutError, (e) ->
      [status: 'error', service: url, message: e.message, raw: e]
    .catch InvalidResponseError, (e) ->
      [status: "error", service: e.service, message: e.message, raw: e.response]


module.exports = oa

