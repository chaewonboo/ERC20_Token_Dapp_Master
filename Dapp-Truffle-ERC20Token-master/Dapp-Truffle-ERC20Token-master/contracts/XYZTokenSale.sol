pragma solidity ^0.4.2;

import "./XYZToken.sol";

contract XYZTokenSale {
	address admin;
	XYZToken public tokenContract;
	uint256 public tokenPrice; 
	uint256 public tokensSold;

	event Sell(address _buyer, uint256 _amount);

	function XYZTokenSale(XYZToken _tokenContract, uint256 _tokenPrice) public {
		// Assign an admin
		admin = msg.sender;

		// Token contract 
		tokenContract = _tokenContract;

		// Token Price 
		tokenPrice = _tokenPrice;
	}

	// multiply
	function multiply(uint x, uint y) internal pure returns (uint z) {
		require(y == 0 || (z = x * y) / y == x);
	}

	function buyTokens(uint256 _numberOfTokens) public payable {
		// Require that value is equal to tokens 
		require(msg.value == multiply(_numberOfTokens, tokenPrice));
		// Require that the contract has enough tokens 
		require(tokenContract.balanceOf(this) >= _numberOfTokens);
		// Require that a transfer is successful  
		require(tokenContract.transfer(msg.sender, _numberOfTokens));

		// Keep track of tokensSold 
		tokensSold += _numberOfTokens;

		// Trigger Sell Event 
		Sell(msg.sender, _numberOfTokens);
	}

	// End token sale 
	function endSale() public {
		// Require admin
		require(msg.sender == admin);

		// Transfer remaining XYZ tokens to admin
		require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));
		
		// Destroy contract
		selfdestruct(admin);
	}

}