# crypto-balance

Query various crypto tokens for their address balances.

Warning: this is a very early version--use at your own risk. Pull requests are very much welcome as well as support for other tokens, blockchains, and services.


## Supported Tokens

- Bitcoin
- Litecoin
- Dogecoin
- All tokens created on Counterparty
- All tokens created on Dogeparty


## Installation

```
~ » npm install crypto-balance
```


## How to Use


### Command Line

```
~ » npm install -g crypto-balance # for global installation of _balance_
~ » balance DDogepartyxxxxxxxxxxxxxxxxxxw1dfzr                                                                      ~
1,009,968,741.03499746 DOGE
~ » balance 1LARSvRshS9Nm3D3aWLELQjNYtaBrWGzg2                                                                      ~
0.00010860 BTC
42.00000000 XCP/LARS
```


### Node.js

```
var balance = require('crypto-balance');
balance("DCt8sxHX634ghqdDhWFtCPQUyZ3TEfLBCo", function(error, assets) {
  console.log(assets);
});

// [ { address: 'DCt8sxHX634ghqdDhWFtCPQUyZ3TEfLBCo',
//    balance: 100000000,
//    token: 'XDP/DOGEPARTY' },
//  { address: 'DCt8sxHX634ghqdDhWFtCPQUyZ3TEfLBCo',
//    balance: 500000000000,
//    token: 'XDP/DOLLARS' },
//  ...
// ]
```


### Promise

```
var balance = require("crypto-balance");
balance("DDogepartyxxxxxxxxxxxxxxxxxxw1dfzr").then(function(balances) {
  console.log(balances);
});

// [ { address: 'DDogepartyxxxxxxxxxxxxxxxxxxw1dfzr',
//  balance: '1399253366.95050883',
//  token: 'DOGE' } ]
```


## Tests

You'll need [mocha](http://visionmedia.github.io/mocha/#installation) installed on your system. Run tests with:

```
npm test
```


## License

[MIT](https://github.com/larskluge/crypto-balance/blob/master/LICENSE)

