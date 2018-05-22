pragma solidity ^0.4.23;

import "../../Helpers/TokenBasics/StandardToken.sol";
import "../../Helpers/Modifiers/Ownable.sol";
import "../../Helpers/Modifiers/Pausable.sol";

/**
 * @title Pausable token
 * @dev StandardToken modified with pausable transfers.
 **/
contract PausableToken is StandardToken, Pausable {
    /**
     * @dev Prevent the token from ever being paused again
     **/
    function transfer(address _to, uint256 _value) public whenNotPaused returns (bool) {
        return super.transfer(_to, _value);
    }
    
    /**
     * @dev transferFrom function to tansfer tokens when token is not paused
     **/
    function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }
    
    /**
     * @dev approve spender when not paused
     **/
    function approve(address _spender, uint256 _value) public whenNotPaused returns (bool) {
        return super.approve(_spender, _value);
    }
    
    /**
     * @dev increaseApproval of spender when not paused
     **/
    function increaseApproval(address _spender, uint _addedValue) public whenNotPaused returns (bool success) {
        return super.increaseApproval(_spender, _addedValue);
    }
    
    /**
     * @dev decreaseApproval of spender when not paused
     **/
    function decreaseApproval(address _spender, uint _subtractedValue) public whenNotPaused returns (bool success) {
        return super.decreaseApproval(_spender, _subtractedValue);
    }
}
