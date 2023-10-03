# NFT Bank Bills

Page: https://smart-contract-developer-challenge.vercel.app/

Contract: https://goerli.etherscan.io/address/0xdefe5dbfe45a3c2e8878c211b404cdf2ac25b256#code

NFTs representing coins and banknotes of different denominations. 

- 1 peso
- 5 pesos
- 10 pesos
- 20 pesos
- 50 pesos
- 100 pesos

Deliver the minimum of each NFT for each transaction. The mission is to calculate the function that converts a number into a list of minimum NFTs to be delivered.

For example:
65 = 50,10,5
98 = 50,20,20,5,1,1,1
341 = 100,100,100,20,20,1

In addition, for each denomination there is a limited stock of NFTs, so we cannot give more than there are.

quantity:
- 1 = 50 units
- 5 = 5 units
- 10 = 5 units
- 20 = 2 units
- 50 = 2 units
- 100 = 20 units

### Practice example:
![173 primero](https://github.com/Lucacez/NFT-Bank-Bills/assets/102439691/c59d7d31-b08b-4987-af65-0c490af545b7)
This is what the website looks like, if you enter a number (in this example 173), and click on Convert() you can see how that amount can be withdrawn based on different NFTs.

If you click on Mint() you can withdraw these NFTs, in this case; one of 100, one of 50, one of 20, and three of 1, which equals 173.
![173 mint](https://github.com/Lucacez/NFT-Bank-Bills/assets/102439691/8eda8181-8a08-4075-8749-0329b7cbe80c)

You can see how the NFTs are minted in etherscan goerli.
![173 after](https://github.com/Lucacez/NFT-Bank-Bills/assets/102439691/f68e10d6-a3db-46f7-bdd9-aacb836a48bc)

Below are the balances, updated after the first mining, of the remaining NFTs.
![173 segundo](https://github.com/Lucacez/NFT-Bank-Bills/assets/102439691/593f3568-f97a-494b-81d3-62cb35ad2e39)

And then if we do another minting, we see how the balance shows how there are no more NFTs reserves of 20 and 50 bills. So if we re-enter 173 and click Convert(), it shows the new way in which you will be able to withdraw that amount. 
One out of 100, five out of 10, four out of 5 and three out of 1, totaling 173.
![173 after2](https://github.com/Lucacez/NFT-Bank-Bills/assets/102439691/1dd0b011-e37a-4b57-a9dd-f1d9ba1b6296)
