shared = require("./_shared")

dogeparty = (addr) -> shared.party(addr, [["XDP", "https://wallet.dogeparty.io/_api"], ["XDPTEST", "http://testnet.wallet.dogeparty.io/_t_api"]])

module.exports = dogeparty

