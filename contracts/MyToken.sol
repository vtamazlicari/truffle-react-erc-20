pragma solidity 0.6.1;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "./ERC20Mintable.sol";

contract MyToken is ERC20, ERC20Detailed, ERC20Mintable {
    constructor() public ERC20Detailed("StarDucks Cappucino Token", "CAPPU", 0) {
    }
}