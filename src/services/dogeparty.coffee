shared = require("./_shared")

# todo: find a better way
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0'

dogeparty = (addr) -> shared.party(addr, [["XDP", "https://wallet.dogeparty.io/_api"], ["XDPTEST", "http://testnet.wallet.dogeparty.io/_t_api"]])

module.exports = dogeparty

