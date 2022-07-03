const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Challenge", function () {
  
  let owner, user2, user3;

  beforeEach(async function(){
    [owner, user2, user3] = await ethers.getSigners();
    
    const Challenge = await ethers.getContractFactory("Challenge", owner);
    
    this.challenge = await Challenge.deploy();
  });

  describe("user", function (){
    it("El usuario puede ver la cantidad los nfts del numero introducido", async function (){
      expect(await this.challenge.connect(user2).ConvertDenom(65));
    })
    it("El usuario puede mintear los nfts del numero introducido", async function (){
      expect(await this.challenge.connect(user3).Mint(350));
      expect(await this.challenge.connect(user3).balanceOf(user3.address, 6)).to.be.eq(3);
      expect(await this.challenge.connect(user3).balanceOf(user3.address, 5)).to.be.eq(1);
    });
  });

  describe("admin", function (){
    it("Solo el admin puede actualizar la cantidad de Nfts", async function (){
      expect(await this.challenge.connect(owner).ChangeStock(50,1,1,1,1,12));
      expect(await this.challenge.connect(owner).BalanceStock());
    })
  });

});
