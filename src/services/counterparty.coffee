shared = require("./_shared")

counterparty = (addr) -> shared.party(addr, [["XCP", "https://counterwallet.io/_api"], ["XCPTEST", "https://counterwallet.io/_t_api"]])

module.exports = counterparty

