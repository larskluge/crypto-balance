mapping = {
  "XCP/XCP": "XCP",
  "XDP/XDP": "XDP",
  "XCP/SJCX": "SJCX"
}

exports.normalize = (name) -> mapping[name] or name

