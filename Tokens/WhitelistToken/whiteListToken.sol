pragma solidity ^0.4.23;

import "../../Helpers/TokenBasics/StandardToken.sol";
import "../../Helpers/Modifiers/Ownable.sol";

/**
 * @title WhiteList Token
 * @dev Token that must be Whitelisted from transfering tokens.
 */
contract WhiteList is StandardToken, Ownable {
  string public constant NAME = "WhiteList Token";
  string public constant SYMBOL = "WLK";
  uint256 public constant DECIMALS = 18;
  uint256 public constant INITIAL_SUPPLY = 500000000 * 10**18;
  
  mapping(address => bool) tokenWhiteList;
  event whiteList(address indexed whiteListed, bool value);

  /**
   * @dev Adds or removes a specific address from the whiteList
   * @param listAddress The address to blacklist or unWhiteList
   * @param isWhiteListed Boolean value determining if the address is whiteList
   */
  function whiteListAddress(address listAddress,  bool isWhiteListed) public onlyOwner {
      _whiteList(listAddress, isWhiteListed);
  }

  /**
   * @dev Adds or removes a specific address from the whitelist
   * @param _address The address to whitelist or unwhitelist
   * @param _isWhiteListed Boolean value determining if the address is whitelisted
   */
  function _whiteList(address _address, bool _isWhiteListed) internal {
    require(tokenWhiteList[_address] != _isWhiteListed);
    tokenWhiteList[_address] = _isWhiteListed;
    emit whiteList(_address, _isWhiteListed);
  }
  
  /**
     * @dev Prevent non-WhiteList address from transfering
     **/
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(tokenWhiteList[msg.sender] == true);
        return super.transfer(_to, _value);
    }
    
    /**
     * @dev Prevent non-WhiteList address from transfering
     **/
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(tokenWhiteList[msg.sender] == true);
        return super.transferFrom(_from, _to, _value);
    }
    
    /**
     * @dev Prevent non-WhiteList address from being approved
     **/
    function approve(address _spender, uint256 _value) public returns (bool) {
        require(tokenWhiteList[msg.sender] == true);
        return super.approve(_spender, _value);
    }
    
    /**
     * @dev Prevent non-whiteList address from increaseApproval
     **/
    function increaseApproval(address _spender, uint _addedValue) public returns (bool success) {
       require(tokenWhiteList[msg.sender] == true);
        return super.increaseApproval(_spender, _addedValue);
    }
    
    /**
     * @dev Prevent non-whiteList address from decreaseApproval
     **/
    function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool success) {
        require(tokenWhiteList[msg.sender] == true);
        return super.decreaseApproval(_spender, _subtractedValue);
    }
  

  /**
   * WhiteList Token Constructor
   * @dev Create and issue tokens to msg.sender.
   */
  constructor() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }  
}
