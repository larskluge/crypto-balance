mapping =
  "XCP/XCP"  : "XCP"
  "XDP/XDP"  : "XDP"
  "XCP/SJCX" : "SJCX"
  "MSC/MSC"  : "MSC"
  "MSC/SP3"  : "MAID"


exports.normalize = (name) -> mapping[name] or name

