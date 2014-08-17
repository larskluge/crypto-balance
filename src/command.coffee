numeral = require("numeral")
balance = require("./crypto-balance")


module.exports.run = ->
  addr = process.argv[2]

  unless addr
    console.log "Usage: balance <address>"
    process.exit 1

  balance addr, (error, assets) ->
    if error
      console.log error
    else
      for asset in assets
        console.log "#{numeral(asset.balance).format("0,0.00000000")} #{asset.token}"

