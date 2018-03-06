pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';

contract COVRToken is MintableToken {
  string public name = "Crowd Coverage Token";
  string public symbol = "COVR";
  uint8 public decimals = 18;
}