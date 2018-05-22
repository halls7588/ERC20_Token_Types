pragma solidity ^0.4.23;

import "../../Helpers/TokenBasics/StandardToken.sol";
import "../../Helpers/Modifiers/Ownable.sol";

/**
 * @title PrivateOwnershipToken token
 * @dev Simple ERC20 Token example with Private Ownership tokens
 */
contract PrivateOwnershipToken is StandardToken, Ownable {
  string public constant NAME = "Private Token";
  string public constant SYMBOL = "PVT";
  uint256 public constant DECIMALS = 18;
  uint256 public constant INITIAL_SUPPLY = 500000000 * 10**18;
  
  mapping (address => bool) canOwnTokens;

  
  /**
   * Determins if an address has premission to own tokens
   **/
  modifier tokensOwnable() {
      require(canOwnTokens[msg.sender]);
      _;
  }

  /**
   * @dev function to add or remove address to the private ownership list. 
   */
  function ownTokens(address _address, bool _value) public onlyOwner  {
        canOwnTokens[_address] = _value;
  }
  
     /**
     * @dev transfer function to tansfer tokens
     **/
    function transfer(address _to, uint256 _value) public tokensOwnable returns (bool) {
        require(canOwnTokens[_to] == true);
        return super.transfer(_to, _value);
    }
    
    /**
     * @dev transferFrom function to tansfer tokens
     **/
    function transferFrom(address _from, address _to, uint256 _value) public tokensOwnable returns (bool) {
        require(canOwnTokens[_to] == true);
        return super.transferFrom(_from, _to, _value);
    }
    
    /**
     * @dev approve spender 
     **/
    function approve(address _spender, uint256 _value) public tokensOwnable returns (bool) {
        return super.approve(_spender, _value);
    }
    
    /**
     * @dev increaseApproval of spender
     **/
    function increaseApproval(address _spender, uint _addedValue) public tokensOwnable returns (bool success) {
        return super.increaseApproval(_spender, _addedValue);
    }
    
    /**
     * @dev decreaseApproval of spender
     **/
    function decreaseApproval(address _spender, uint _subtractedValue) public tokensOwnable returns (bool success) {
        return super.decreaseApproval(_spender, _subtractedValue);
    }
    
  
  /**
   * Private Ownership Token Constructor
   * @dev Create and issue tokens to msg.sender.
   * @dev Add owner to private ownership list
   */
  constructor() public {
    totalSupply_ = INITIAL_SUPPLY;
    canOwnTokens[msg.sender] = true;
    balances[msg.sender] = INITIAL_SUPPLY;
  } 
}
