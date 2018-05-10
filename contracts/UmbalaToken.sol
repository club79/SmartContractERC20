pragma solidity ^0.4.18;

import '../zeppelin-solidity/contracts/token/MintableToken.sol';

contract UmbalaToken is MintableToken {

  
  string public name = "AHIHI";
  string public symbol = "OPTK";
  uint8 public decimals = 18;
  uint256 public totalSupply = 200000000000000000000;

  function UmbalaToken () public { 
      //transferOwnership(newOwner);
  }
  
  function transfer(address _to, uint256 _value) public  returns (bool success) {
    require(!locked);    
    return super.transfer(_to,_value);
  }

  // /**
  //    * Destroy tokens
  //    *
  //    * Remove `_value` tokens from the system irreversibly
  //    *
  //    * @param _value the amount of money to burn
  //    */
  //   function burn(uint256 _value) public returns (bool) {
  //       burnFrom(msg.sender, _value);
  //   }

  //   /**
  //    * Destroy tokens from other account
  //    *
  //    * Remove `_value` tokens from the system irreversibly on behalf of `_from`.
  //    *
  //    * @param _from the address of the sender
  //    * @param _value the amount of money to burn
  //    */
  //   function burnFrom(address _from, uint256 _value) public returns (bool) {
  //       require(!locked);    
  //       require(balances[_from] >= _value);                // Check if the targeted balance is enough
  //       balances[_from] -= _value;                         // Subtract from the targeted balance
  //       totalSupply -= _value;                              // Update totalSupply
  //       Burn(_from, _value);
  //       return true;
  //   }
}