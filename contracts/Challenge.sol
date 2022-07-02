// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Challenge is ERC1155, Ownable {
  constructor() ERC1155("") {
    _mint(address(this), 1 /* Id 1 Peso      */, 50 /* Cantidad */, "");
    _mint(address(this), 2 /* Id 5 Pesos     */, 5  /* Cantidad */, "");
    _mint(address(this), 3 /* Id 10 Pesos    */, 5  /* Cantidad */, "");
    _mint(address(this), 4 /* Id 20 Pesos    */, 2  /* Cantidad */, "");
    _mint(address(this), 5 /* Id 50 Pesos    */, 2  /* Cantidad */, "");
    _mint(address(this), 6 /* Id 100 Pesos   */, 20 /* Cantidad */, "");
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
  

  function ChangeStock(
    uint peso1, uint peso5, uint peso10, uint peso20, uint peso50, uint peso100
    ) 
    public
    onlyOwner()
  {
    _mint(address(this), 1, peso1, "");
    _mint(address(this), 2, peso5, "");
    _mint(address(this), 3, peso10, "");
    _mint(address(this), 4, peso20, "");
    _mint(address(this), 5, peso50, "");
    _mint(address(this), 6, peso100, "");
  }

  function ConvertDenom(uint _value) public view returns(Person memory){
    
    Person memory person;
    uint value = _value;


    if((value / 100) != 0){
      if(balanceOf(address(this), 6) != 0){
        if(balanceOf(address(this), 6) >= value / 100){
          person.peso100 = value / 100;
          value = value - (100 * (value / 100));
        }else{
          person.peso100 = balanceOf(address(this), 6);
          value = value - (100 * (balanceOf(address(this), 6)));
        }
      }
    }

    if((value / 50) != 0){
      if(balanceOf(address(this), 5) != 0){
        if(balanceOf(address(this), 5) >= value / 50){
          person.peso50 = value / 50;
          value = value - (50 * (value / 50));
        }else{
          person.peso50 = balanceOf(address(this), 5);
          value = value - (50 * (balanceOf(address(this), 5)));
        }
      }
    }

    if((value / 20) != 0){
      if(balanceOf(address(this), 4) != 0){
        if(balanceOf(address(this), 4) >= value / 20){
          person.peso20 = value / 20;
          value = value - (20 * (value / 20));
        }else{
          person.peso20= balanceOf(address(this), 4);
          value = value - (20 * (balanceOf(address(this), 4)));
        }
      }
    }

    if((value / 10) != 0){
      if(balanceOf(address(this), 3) != 0){
        if(balanceOf(address(this), 3) >= value / 10){
          person.peso10 = value / 10;
          value = value - (10 * (value / 10));
        }else{
          person.peso10 = balanceOf(address(this), 3);
          value = value - (10 * (balanceOf(address(this), 3)));
        }
      }
    }

    if((value / 5) != 0){
      if(balanceOf(address(this), 2) != 0){
        if(balanceOf(address(this), 2) >= value / 5){
          person.peso5 = value / 5;
          value = value - (5 * (value / 5));
        }else{
          person.peso5 = balanceOf(address(this), 2);
          value = value - (5 * (balanceOf(address(this), 2)));
        }
      }
    }

    if((value / 1) != 0){
      if(balanceOf(address(this), 1) != 0){
        if(balanceOf(address(this), 1) >= value / 1){
          person.peso1 = value / 1;
          value = value - (1 * (value / 1));
        }else{
          person.peso1 = balanceOf(address(this), 1);
          value = value - (1 * (balanceOf(address(this), 1)));
        }
      }
    }

    return person;
  }

  function Mint(uint _value) public{
    Person memory person = ConvertDenom(_value);
    _safeTransferFrom(address(this), msg.sender, 6, person.peso100, "");
    _safeTransferFrom(address(this), msg.sender, 5, person.peso50, "");
    _safeTransferFrom(address(this), msg.sender, 4, person.peso20, "");
    _safeTransferFrom(address(this), msg.sender, 3, person.peso10, "");
    _safeTransferFrom(address(this), msg.sender, 2, person.peso5, "");
    _safeTransferFrom(address(this), msg.sender, 1, person.peso1, "");
  }
  
  


}