var XYZToken = artifacts.require("./XYZToken.sol");
var XYZTokenSale = artifacts.require("./XYZTokenSale.sol");

module.exports = function(deployer) {
  deployer.deploy(XYZToken, 1000000).then(function(){
  	// Token price is 0.001 Ether
  	var tokenPrice = 1000000000000000;
  	return deployer.deploy(XYZTokenSale, XYZToken.address, tokenPrice);
  });
};