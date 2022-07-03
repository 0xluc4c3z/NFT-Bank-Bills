require("@nomiclabs/hardhat-waffle");
require('dotenv').config()
require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-etherscan");

const projectId = process.env.INFURA_PROJECT_ID
const privateKey = process.env.DEPLOYER_SIGNER_PRIVATE_KEY

module.exports = {
  solidity: {
    version: "0.8.6",
    settings: {
      optimizer: {
        enabled: true,
        runs: 10000
      },
    },
  },
  networks: {
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${projectId}`,
      accounts: [privateKey],
    },
  },
  gasReporter: {
    enabled: (process.env.REPORT_GAS) ? true : false,
    currency: 'DAI',
    coinmarketcap: process.env.COINMARKETCAP_API_KEY
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_KEY,
  },
};
