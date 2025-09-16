var MyToken = artifacts.require("MyToken");
var MyTokenSale = artifacts.require("MyTokenSale");
var MyKycContract = artifacts.require("KycContract");
require("dotenv").config({path: "../.env"});

module.exports = async function(deployer) {
    let addr = await web3.eth.getAccounts();
    await deployer.deploy(MyToken);
    await deployer.deploy(MyKycContract);
    await deployer.deploy(MyTokenSale, 1, addr[0], MyToken.address, MyKycContract.address);
    let token = await MyToken.deployed();
    await token.addMinter(MyTokenSale.address);
};