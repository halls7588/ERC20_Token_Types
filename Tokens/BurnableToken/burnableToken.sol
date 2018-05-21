pragma solidity ^0.4.23;

import "../../Helpers/TokenBasics/StandardToken.sol";

/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed).
 */
contract BurnableToken is StandardToken {
  string public constant NAME = "Burn Token";
  string public constant SYMBOL = "BURN";
  uint256 public constant DECIMALS = 18;

  uint256 public constant INITIAL_SUPPLY = 500000000 * 10**18;

  event Burn(address indexed burner, uint256 value);

  /**
   * @dev Burns a specific amount of tokens.
   * @param _value The amount of token to be burned.
   */
  function burn(uint256 _value) public {
    _burn(msg.sender, _value);
  }

  function _burn(address _who, uint256 _value) internal {
    require(_value <= balances[_who]);
    // no need to require value <= totalSupply, since that would imply the
    // sender's balance is greater than the totalSupply, which *should* be an assertion failure

    balances[_who] = balances[_who].sub(_value);
    totalSupply_ = totalSupply_.sub(_value);
    emit Burn(_who, _value);
    emit Transfer(_who, address(0), _value);
  }

  /**
   * Burnable Token Constructor
   * @dev Create and issue tokens to msg.sender.
   */
  constructor() public {
    totalSupply = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }
  
}
