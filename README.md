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
~ » balance 1sbeSvsvU8GVZsVZopY7hB8DimDxfDArQ
0.00458889 BTC
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


## License

[MIT](https://github.com/larskluge/crypto-balance/blob/master/LICENSE)

