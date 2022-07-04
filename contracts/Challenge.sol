// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/* --------------------------------- Errors -------------------------------- */
error ZeroNot();
error NotIdealValue();

contract Challenge is ERC1155, Ownable, ReentrancyGuard {
  
  constructor() ERC1155("") {
    Stock = Cash(50,5,5,2,2,20);
  }

   /// @notice Struct: representa el stock limitado inicial
  struct Cash{
    uint peso1;
    uint peso5;
    uint peso10;
    uint peso20;
    uint peso50;
    uint peso100;
  }

  /// @notice Instancia que almacena el stock inicial, utilizada para la conversion
  Cash Stock;
  
  /* --------------------------------- Admin function -------------------------------- */
  /// @notice Funcion que actualiza el stock inicial
  function ChangeStock(
    uint peso1, uint peso5, uint peso10, uint peso20, uint peso50, uint peso100
    ) 
    public
    onlyOwner()
  {
    Stock.peso1 = peso1;
    Stock.peso5 = peso5;
    Stock.peso10 = peso10;
    Stock.peso20 = peso20;
    Stock.peso50 = peso50;
    Stock.peso100 = peso100;
  }

  /* --------------------------------- View function -------------------------------- */

  /// @notice Funcion que actualiza devuelve 
  function BalanceStock() public view returns(Cash memory){
    return Stock;
  }

  /// @notice Se utiliza la intancia "stock" para consultar el limite actual
  /// @notice Se crea la intancia "amount" que devuelve la cantidad de billetes necesarios 
  /// @notice Revierte si se ingresa un numero 0 o menor/ revierte si no se llega con el stock al valor indicado
  function ConvertDenom(uint _value) public view returns(Cash memory){
    
    if(_value == 0){
      revert ZeroNot();
    }

    Cash memory stock = Stock;
    Cash memory amount;
    uint value = _value;
    uint totalValue = 0;


    if((value / 100) != 0){
      if(stock.peso100 != 0){
        if(stock.peso100 >= value / 100){
          amount.peso100 = value / 100;
          totalValue += (100 * value / 100);
          value = value - (100 * (value / 100));
        }else{
          amount.peso100 = stock.peso100;
          totalValue += (100 * stock.peso100);
          value = value - (100 * stock.peso100);
        }
      }
    }

    if((value / 50) != 0){
      if(stock.peso50 != 0){
        if(stock.peso50 >= value / 50){
          amount.peso50 = value / 50;
          totalValue += (50 * (value / 50));
          value = value - (50 * (value / 50));
        }else{
          amount.peso50 = stock.peso50;
          totalValue += (50 * stock.peso50);
          value = value - (50 * stock.peso50);
        }
      }
    }

    if((value / 20) != 0){
      if(stock.peso20 != 0){
        if(stock.peso20 >= value / 20){
          amount.peso20 = value / 20;
          totalValue += (20 * (value / 20));
          value = value - (20 * (value / 20));
        }else{
          amount.peso20= stock.peso20;
          totalValue += (20 * stock.peso20);
          value = value - (20 * stock.peso20);
        }
      }
    }

    if((value / 10) != 0){
      if(stock.peso10  != 0){
        if(stock.peso10 >= value / 10){
          amount.peso10 = value / 10;
          totalValue += (10 * (value / 10));
          value = value - (10 * (value / 10));
        }else{
          amount.peso10 = stock.peso10;
          totalValue += (10 * stock.peso10);
          value = value - (10 * stock.peso10);
        }
      }
    }

    if((value / 5) != 0){
      if(stock.peso5 != 0){
        if(stock.peso5 >= value / 5){
          amount.peso5 = value / 5;
          totalValue += (5 * (value / 5));
          value = value - (5 * (value / 5));
        }else{
          amount.peso5 = stock.peso5;
          totalValue += (5 * stock.peso5);
          value = value - (5 * stock.peso5);
        }
      }
    }

    if((value / 1) != 0){
      if(stock.peso1 != 0){
        if(stock.peso1 >= value / 1){
          amount.peso1 = value / 1;
          totalValue += (1 * (value / 1));
          value = value - (1 * (value / 1));
        }else{
          amount.peso1 = stock.peso1;
          totalValue += (1 * stock.peso1);
          value = value - (1 * stock.peso1);
        }
      }
    }

    if(totalValue < _value){
      revert NotIdealValue();
    }

    return amount;
  }

  /// @notice Se encarga de realizar el mint de los nfts utilizados para representar el valor indicado
  /// @notice "amount" se utiliza para mintear los nfts que se utilizan en el desglose del valor
  function Mint(uint256 _value) public nonReentrant(){

    Cash memory amount = ConvertDenom(_value);

    if(amount.peso1 != 0){
      _mint(msg.sender, 1, amount.peso1, "");
    }
    if(amount.peso5 != 0){
      _mint(msg.sender, 2, amount.peso5, "");
    }
    if(amount.peso10 != 0){
      _mint(msg.sender, 3, amount.peso10, "");
    }
    if(amount.peso20 != 0){
      _mint(msg.sender, 4, amount.peso20, "");
    }
    if(amount.peso50 != 0){
      _mint(msg.sender, 5, amount.peso50, "");
    }
    if(amount.peso100 != 0){
      _mint(msg.sender, 6, amount.peso100, "");
    }

    Stock.peso1 -= amount.peso1;
    Stock.peso5 -= amount.peso5;
    Stock.peso10 -= amount.peso10;
    Stock.peso20 -= amount.peso20;
    Stock.peso50 -= amount.peso50;
    Stock.peso100 -= amount.peso100;
  }
}