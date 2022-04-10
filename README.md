<img align="right" width="160" height="160" top="100" src="./assets/readme.jpeg">

# forge-erc20 • [![tests](https://github.com/soliditylabs/forge-erc20-template/actions/workflows/tests.yml/badge.svg)](https://github.com/soliditylabs/forge-erc20-template/actions/workflows/tests.yml) [![lints](https://github.com/soliditylabs/forge-erc20-template/actions/workflows/lints.yml/badge.svg)](https://github.com/soliditylabs/forge-erc20-template/actions/workflows/lints.yml) ![GitHub](https://img.shields.io/github/license/soliditylabs/forge-erc20-template) ![GitHub package.json version](https://img.shields.io/github/package-json/v/soliditylabs/forge-erc20-template)

Template for Forge based on [femplate](https://github.com/abigger87/femplate) and [forge-template](https://github.com/FrankieIsLost/forge-template) with ERC-20 example tests.

## Getting Started

Click `use this template` on [Github](https://github.com/soliditylabs/forge-erc20-template) to create a new repository with this repo as the initial state.

Or run (also works for existing projects):

```bash
forge init --template https://github.com/soliditylabs/forge-erc20-template
git submodule update --init --recursive
forge install
```

## Blueprint

```ml
lib
├─ ds-test — https://github.com/dapphub/ds-test
├─ forge-std — https://github.com/brockelmore/forge-std
├─ openzeppelin-contracts — https://github.com/OpenZeppelin/openzeppelin-contracts
src
├─ tests
│  └─ MyERC20.t — "ERC-20 Transfer Tests"
└─ MyERC20 — "A Minimal ERC-20 Contract"
```

## Development

**Building**

```bash
forge build
```

**Testing**

```bash
forge test -vvvvv
```

**Deployment & Verification**

Copy the .env.example file to .env and update the values.

To deploy the ERC-20 to Rinkeby:

```bash
./scripts/deploy-to-rinkeby.sh
```

To verify the ERC-20 on Rinkeby:

```bash
./scripts/deploy-to-rinkeby.sh
```

### First time with Forge/Foundry?

See the official Foundry installation [instructions](https://github.com/gakonst/foundry/blob/master/README.md#installation).

Then, install the [foundry](https://github.com/gakonst/foundry) toolchain installer (`foundryup`) with:

```bash
curl -L https://foundry.paradigm.xyz | bash
```

Now that you've installed the `foundryup` binary,
anytime you need to get the latest `forge` or `cast` binaries,
you can run `foundryup`.

So, simply execute:

```bash
foundryup
```

🎉 Foundry is installed! 🎉

### Writing Tests with Foundry

With [Foundry](https://gakonst.xyz), tests are written in Solidity! 🥳

Create a test file for your contract in the `src/tests/` directory.

For example, [`src/MyERC20.sol`](./src/MyERC20.sol) has its test file defined in [`./src/tests/MyERC20.t.sol`](./src/tests/MyERC20.t.sol).

### Configure Foundry

Using [foundry.toml](./foundry.toml), Foundry is easily configurable.

For a full list of configuration options, see the Foundry [configuration documentation](https://github.com/gakonst/foundry/blob/master/config/README.md#all-options).

## License

[MIT](https://github.com/soliditylabs/forge-erc20-template/blob/master/LICENSE)

## Acknowledgements

- [femplate](https://github.com/abigger87/femplate) as main reference
- [foundry](https://github.com/gakonst/foundry)
- [Openzeppelin](https://github.com/Openzeppelin/openzeppelin-contracts)
- [forge-std](https://github.com/brockelmore/forge-std)
- [forge-template](https://github.com/FrankieIsLost/forge-template) by [FrankieIsLost](https://github.com/FrankieIsLost).
- [Georgios Konstantopoulos](https://github.com/gakonst) for [forge-template](https://github.com/gakonst/forge-template) resource.

## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._
