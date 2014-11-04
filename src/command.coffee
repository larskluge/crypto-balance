numeral = require("numeral")
balance = require("./crypto-balance")


module.exports.run = ->
  addr = process.argv[2]

  unless addr
    console.log "Usage: balance <address>"
    process.exit 1

  balance addr
    .then (items) ->
      for item in items
        if item.status == 'success'
          console.log "#{numeral(item.quantity).format("0,0.00000000")} #{item.asset}"
        else
          console.error item
    .catch (error) ->
      console.error error
      process.exit 1

