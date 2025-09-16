pragma solidity 0.6.1;

import "./Crowdsale.sol";
import "./KycContract.sol";
import "./ERC20Mintable.sol";

contract MyTokenSale is Crowdsale {

    KycContract kyc;

    constructor(
        uint256 rate,    // rate in TKNbits
        address payable wallet,
        IERC20 token,
        KycContract _kyc
    )
        Crowdsale(rate, wallet, token)
        public
    {
        kyc = _kyc;
    }

    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal view override {
        super._preValidatePurchase(beneficiary, weiAmount);
        require(kyc.kycCompleted(msg.sender), "KYC Not completed, purchase not allowed");
    }

    function _deliverTokens(address beneficiary, uint256 tokenAmount) internal override {
        require(
            ERC20Mintable(address(token())).mint(beneficiary, tokenAmount),
            "Mint on purchase failed"
        );
    }
}