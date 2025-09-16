# StarDucks Cappucino Token (CAPPU)

An ERC-20 token sale with a KYC whitelist, built with Truffle, OpenZeppelin and a React front end.

- **`MyToken`**: mintable ERC-20 token `CAPPU` ("StarDucks Cappucino Token") with 0 decimals.
- **`KycContract`**: an owner-managed whitelist of addresses that are allowed to buy.
- **`MyTokenSale`**: a crowdsale that mints tokens to the buyer on purchase (rate: 1 wei = 1 CAPPU). It rejects buyers who are not on the KYC whitelist.

The React app (`client/`) lets the contract owner whitelist addresses and lets whitelisted users buy tokens and see their balance.

## Project structure

```
contracts/        Solidity sources (solc 0.6.1)
migrations/       Deployment scripts
test/             Truffle tests (chai, chai-bn, chai-as-promised)
client/           React app (Create React App + web3)
client/src/contracts/   Compiled contract artifacts (Truffle build output)
truffle-config.js Networks and compiler config
```

## Prerequisites

- Node.js and npm
- [Truffle](https://trufflesuite.com/) (`npm install -g truffle`)
- [MetaMask](https://metamask.io/) in your browser

## Setup

```bash
npm install
cd client && npm install
```

Create a `.env` file in the project root (it is git-ignored):

```
MNEMONIC="your twelve word seed phrase ..."
INFURA_PROJECT_ID="your infura project id"
```

`MNEMONIC` is only needed for the `ganache_local`, `goerli_infura`, `ropsten_infura` and `sepolia` networks. `INFURA_PROJECT_ID` is only needed for the three Infura testnets. Never commit either.

## Run locally

1. Start a local chain on port 9545, for example with `truffle develop`. The `development` network expects `127.0.0.1:9545` with network id `1337`.
2. Deploy the contracts:

   ```bash
   truffle migrate --network development
   ```

   The migration deploys `MyToken`, `KycContract` and `MyTokenSale`, then grants the sale contract the minter role. Artifacts are written to `client/src/contracts/`, where the React app reads them.
3. Start the front end:

   ```bash
   cd client
   npm start
   ```

4. Open http://localhost:3000. Connect MetaMask to `http://127.0.0.1:9545` and import the deployer account.

## Using the dApp

1. **KYC whitelisting**: as the contract owner (the deployer account), enter an address and click **Add to Whitelist**.
2. **Buy tokens**: from a whitelisted account, click **Buy more tokens** (sends 1 wei, mints 1 CAPPU). You can also send wei directly to the token sale address shown on the page.

Your CAPPU balance updates automatically when a `Transfer` event arrives.

## Tests

```bash
truffle test
```

`test/MyToken.test.js` covers minting and transfers. `test/MyTokenSale.test.js` checks the deployed sale: no pre-minted supply, and purchases after KYC.

## Deploy to a testnet

Put a funded account's mnemonic and your Infura project ID in `.env`, then:

```bash
truffle migrate --network sepolia
```

Goerli and Ropsten are still configured but both are deprecated.
