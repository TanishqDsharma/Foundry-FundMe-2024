# Foundry FundMe Project:

## About:
This is a Crowd Sourcing APP. 

## Getting Started:

### Pre-Requisite's:

Install GIT and Foundry

### Project SetUp:
```
git clone https://github.com/Cyfrin/foundry-fund-me-f23
cd foundry-fund-me-f23
forge build
```

## Usage:

### Deploy:
```
forge script script/DeployFundMe.s.sol
```

### Testing
```
forge test // To test all the tests available
OR
forge test --match-test <test_name> // To test only a specific test
OR
forge test --fork-url $SEPOLIA_RPC_URL // To test on a testnet
```

### Test Coverage
```
forge coverage
```

 Deployment to a testnet or mainnet

1. Setup environment variables

You'll want to set your `SEPOLIA_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

Optionally, add your `ETHERSCAN_API_KEY` if you want to verify your contract on [Etherscan](https://etherscan.io/).

2. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some testnet ETH. You should see the ETH show up in your metamask.

3. Deploy

```
forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

## Scripts

After deploying to a testnet or local net, you can run the scripts. 

Using cast deployed locally example: 

```
cast send <FUNDME_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
```

or
```
forge script script/Interactions.s.sol --rpc-url sepolia  --private-key $PRIVATE_KEY  --broadcast
```

### Withdraw

```
cast send <FUNDME_CONTRACT_ADDRESS> "withdraw()"  --private-key <PRIVATE_KEY>
```

### Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```

And you'll see an output file called `.gas-snapshot`


#### Formatting


To run code formatting:
```
forge fmt
```

# Thankyou!

If you appreciated this, feel free to follow me !
-------------------------------------------------
[![Tanishq's Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/Tanishq_eth)



