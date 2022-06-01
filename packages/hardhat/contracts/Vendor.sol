pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);
  uint256 public constant tokensPerEth = 100;

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  function buyTokens() public payable {
    uint256 _transferAmount = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, _transferAmount);
    emit BuyTokens(msg.sender, _transferAmount, msg.value);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public payable onlyOwner {
    //yourToken.transfer(msg.sender, msg.value);
  }

  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 _amount) public payable {
    //yourToken.approve(address(this), 0);
    //yourToken.approve(address(this), _amount);
    yourToken.transferFrom(msg.sender, address(this), _amount);
    payable(msg.sender).transfer(_amount/tokensPerEth);
    emit SellTokens(msg.sender, _amount, _amount/tokensPerEth);
  }
}