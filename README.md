### `npm install` to install dependencies 

# My approach to the Smart Contract Developer Challenge

The project is divided into two sections: `Smart Contracts` & `Frontend`.

## Tech used

-   `Smart Contracts`:
    -   Solidity - _Smart Contracts_
    -   Hardhat - _Development Framework_
-   `Frontend`
    -   React - _UI Framework_ (WIP)
    -   Ethers.js - _Web3 Library_ (WIP)

---

### Smart Contracts

As far as the description goes, only one contract is required, which is `Challenge`.

Functions:

-   (Public) Mint.

--

-   (Owner) Change Stock.

--

-   (Read) Convert Denomination.
-   (Read) Balance Stock.

The system must:

- Represent coins and bills with different denominations.
- Deliver the minimum of each NFTs for each transaction.
- Limited stock but can be updated by the admin.
- Keep track of how many NFTs are left of each (if there are no 20's left, you must now turn in with the 5's or 1's that are left).

### Links

System was deployed on the Rinkeby test network
https://rinkeby.etherscan.io/address/0x23EC7E2267F22F30a6C304b832557929E9a19b7C

The frontend was deployed in vercel
https://smart-contract-developer-challenge.vercel.app/
