const mycontract = artifacts.require("../ERC721/contracts/MyTokenERC721.sol");

module.exports = function(deployer) {
  deployer.deploy(mycontract,"MTK721","MTK");
};
