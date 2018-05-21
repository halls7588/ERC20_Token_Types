pragma solidity ^0.4.23;

import "../../Helpers/TokenBasics/StandardToken.sol";
import "../../Helpers/Modifiers/Ownable.sol";

/**
 * @title Mineable token
 * @dev Simple ERC20 Token example, with Mineable token creation
 */
contract MineableToken is StandardToken, Ownable {
  string public constant NAME = "MintableToken Token";
  string public constant SYMBOL = "MNT";
  uint256 public constant DECIMALS = 18;
  uint256 public constant INITIAL_SUPPLY = 500000000 * 10**18;
  uint256 public miningReward = 1;
  
  event Mine(address indexed to, uint256 amount);
  
  /**
   * Determins is it is possible to continue mining at current reward;
   **/
  modifier canMine() {
      totalSupply_.add(miningReward);
      _;
  }

  /**
   * @dev Function to mint tokens
   * @return A boolean that indicates if the operation was successful.
   */
  function mine() public canMine returns (bool)  {
    totalSupply_ = totalSupply_.add(miningReward);
    balances[msg.sender] = balances[msg.sender].add(miningReward);
    emit Mine(msg.sender, miningReward);
    emit Transfer(address(0), msg.sender, miningReward);
    return true;
  }
  
  /**
   * sets the value of tokens earned by mining reward
   **/
  function setMiningReward(uint256 _value) public onlyOwner{
      require(_value >= 0);
      miningReward = _value;
  }
  
  
  /**
   * MineableToken Token Constructor
   * @dev Create and issue tokens to msg.sender.
   */
  constructor() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  } 
}
