pragma solidity ^0.4.23;

import "../../Helpers/TokenBasics/StandardToken.sol";

/**
 * @title Lavevel Token
 * @dev Simple ERC20 Token with standard token functions.
 */
contract BasicToken is StandardToken {
  string public constant NAME = "Lavevel Token";
  string public constant SYMBOL = "LVL";
  uint256 public constant DECIMALS = 18;

  uint256 public constant INITIAL_SUPPLY = 500000000 * 10**18;

  /**
   * Lavevel Token Constructor
   * @dev Create and issue tokens to msg.sender.
   */
  constructor() public {
    totalSupply = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }
}
