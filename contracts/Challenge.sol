// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

//execution
//3580933
//3113854

//Mint
//157763
//137185

error ZeroNot();
error NotIdealValue();

contract Challenge is ERC1155, Ownable, ReentrancyGuard {
  constructor() ERC1155("") {
    per = Person(50,5,5,2,2,20);
  }

  // Estructura de pesos actualizable
  struct Person{
    uint peso1;
    uint peso5;
    uint peso10;
    uint peso20;
    uint peso50;
    uint peso100;
  }

  Person per;
  

  function ChangeStock(
    uint peso1, uint peso5, uint peso10, uint peso20, uint peso50, uint peso100
    ) 
    public
    onlyOwner()
  {
    per.peso1 = peso1;
    per.peso5 = peso5;
    per.peso10 = peso10;
    per.peso20 = peso20;
    per.peso50 = peso50;
    per.peso100 = peso100;
  }

  function ConvertDenom(uint _value) public view returns(Person memory){
    
    if(_value == 0){
      revert ZeroNot();
    }

    Person memory amount = per;
    Person memory person;
    uint value = _value;
    uint totalValue = 0;


    if((value / 100) != 0){
      if(amount.peso100 != 0){
        if(amount.peso100 >= value / 100){
          person.peso100 = value / 100;
          totalValue += (100 * value / 100);
          value = value - (100 * (value / 100));
        }else{
          person.peso100 = amount.peso100;
          totalValue += (100 * amount.peso100);
          value = value - (100 * amount.peso100);
        }
      }
    }

    if((value / 50) != 0){
      if(amount.peso50 != 0){
        if(amount.peso50 >= value / 50){
          person.peso50 = value / 50;
          totalValue += (50 * (value / 50));
          value = value - (50 * (value / 50));
        }else{
          person.peso50 = amount.peso50;
          totalValue += (50 * amount.peso50);
          value = value - (50 * amount.peso50);
        }
      }
    }

    if((value / 20) != 0){
      if(amount.peso20 != 0){
        if(amount.peso20 >= value / 20){
          person.peso20 = value / 20;
          totalValue += (20 * (value / 20));
          value = value - (20 * (value / 20));
        }else{
          person.peso20= amount.peso20;
          totalValue += (20 * amount.peso20);
          value = value - (20 * amount.peso20);
        }
      }
    }

    if((value / 10) != 0){
      if(amount.peso10  != 0){
        if(amount.peso10 >= value / 10){
          person.peso10 = value / 10;
          totalValue += (10 * (value / 10));
          value = value - (10 * (value / 10));
        }else{
          person.peso10 = amount.peso10;
          totalValue += (10 * amount.peso10);
          value = value - (10 * amount.peso10);
        }
      }
    }

    if((value / 5) != 0){
      if(amount.peso5 != 0){
        if(amount.peso5 >= value / 5){
          person.peso5 = value / 5;
          totalValue += (5 * (value / 5));
          value = value - (5 * (value / 5));
        }else{
          person.peso5 = amount.peso5;
          totalValue += (5 * amount.peso5);
          value = value - (5 * amount.peso5);
        }
      }
    }

    if((value / 1) != 0){
      if(amount.peso1 != 0){
        if(amount.peso1 >= value / 1){
          person.peso1 = value / 1;
          totalValue += (1 * (value / 1));
          value = value - (1 * (value / 1));
        }else{
          person.peso1 = amount.peso1;
          totalValue += (1 * amount.peso1);
          value = value - (1 * amount.peso1);
        }
      }
    }

    if(totalValue < _value){
      revert NotIdealValue();
    }

    return person;
  }

  function Mint(uint _value) public nonReentrant(){

    Person memory person = ConvertDenom(_value);

    _mint(msg.sender, 1, person.peso1, "");
    _mint(msg.sender, 2, person.peso5, "");
    _mint(msg.sender, 3, person.peso10, "");
    _mint(msg.sender, 4, person.peso20, "");
    _mint(msg.sender, 5, person.peso50, "");
    _mint(msg.sender, 6, person.peso100, "");

    per.peso1 -= person.peso1;
    per.peso5 = person.peso5;
    per.peso10 = person.peso10;
    per.peso20 = person.peso20;
    per.peso50 = person.peso50;
    per.peso100 = person.peso100;
  }
}