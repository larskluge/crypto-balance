shared = require("./_shared")

counterparty = (addr) -> shared.party(addr, [["XCP", "https://counterwallet.co/_api"], ["XCPTEST", "https://counterwallet.co/_t_api"]])

module.exports = counterparty

