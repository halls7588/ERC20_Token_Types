pragma solidity ^0.4.23;

import "../../Helpers/TokenBasics/StandardToken.sol";
import "../../Helpers/Modifiers/Ownable.sol";

/**
 * @title Blacklist Token
 * @dev Token that can be blacklist from transfering tokens.
 */
contract BlacklistToken is StandardToken, Ownable {
  string public constant NAME = "Blacklist Token";
  string public constant SYMBOL = "BLK";
  uint256 public constant DECIMALS = 18;
  uint256 public constant INITIAL_SUPPLY = 500000000 * 10**18;
  
  mapping(address => bool) tokenBlacklist;
  event Blacklist(address indexed blackListed, bool value);

  /**
   * @dev Adds or removes a specific address from the blacklist
   * @param listAddress The address to blacklist or unblacklist
   * @param isBlackListed Boolean value determining if the address is blackListed
   */
  function blackListAddress(address listAddress,  bool isBlackListed) public onlyOwner {
      _blackList(listAddress, isBlackListed);
  }

  /**
   * @dev Adds or removes a specific address from the blacklist
   * @param _address The address to blacklist or unblacklist
   * @param _isBlackListed Boolean value determining if the address is blackListed
   */
  function _blackList(address _address, bool _isBlackListed) internal {
    require(tokenBlacklist[_address] != _isBlackListed);
    tokenBlacklist[_address] = _isBlackListed;
    emit Blacklist(_address, _isBlackListed);
  }
  
  /**
     * @dev Prevent blacklisted address from transfering
     **/
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(tokenBlacklist[msg.sender] == false);
        return super.transfer(_to, _value);
    }
    
    /**
     * @dev Prevent blacklisted address from transfering
     **/
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(tokenBlacklist[msg.sender] == false);
        return super.transferFrom(_from, _to, _value);
    }
    
    /**
     * @dev Prevent blacklisted address from being approved
     **/
    function approve(address _spender, uint256 _value) public returns (bool) {
        require(tokenBlacklist[msg.sender] == false);
        return super.approve(_spender, _value);
    }
    
    /**
     * @dev Prevent blacklisted address from increaseApproval
     **/
    function increaseApproval(address _spender, uint _addedValue) public returns (bool success) {
       require(tokenBlacklist[msg.sender] == false);
        return super.increaseApproval(_spender, _addedValue);
    }
    
    /**
     * @dev Prevent blacklisted address from decreaseApproval
     **/
    function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool success) {
        require(tokenBlacklist[msg.sender] == false);
        return super.decreaseApproval(_spender, _subtractedValue);
    }
  

  /**
   * Blacklist Token Constructor
   * @dev Create and issue tokens to msg.sender.
   */
  constructor() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }  
}
