var HDWalletProvider = require("truffle-hdwallet-provider");
var infura_apikey = "3f0jQaefMcHKOJxYGMbY"; // Either use this key or get yours at https://infura.io/signup. It's free.
var mnemonic = "tower enemy genius oak long knee cross december minute connect air sell";

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 7545,
      gas: 6500000,
      network_id: "5777"
    },
    ropsten:  {
      provider: new HDWalletProvider(mnemonic, "https://ropsten.infura.io/" + infura_apikey),
      network_id: 3,
      gas: 4500000
    },
    kovan:  {
      provider: new HDWalletProvider(mnemonic, "https://kovan.infura.io/" + infura_apikey),
      network_id: 42,
      gas: 4500000
    },
    rinkeby:  {
      provider: new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/" + infura_apikey),
      network_id: 4,
      gas: 4500000
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};