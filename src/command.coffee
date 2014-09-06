numeral = require("numeral")
balance = require("./crypto-balance")


module.exports.run = ->
  addr = process.argv[2]

  unless addr
    console.log "Usage: balance <address>"
    process.exit 1

  balance addr, (error, items) ->
    if error
      console.log error
      process.exit 1
    else
      for item in items
        console.log "#{numeral(item.quantity).format("0,0.00000000")} #{item.asset}"

