pragma solidity ^0.4.18;

import './COVRToken.sol';
import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/RefundableCrowdsale.sol';

contract COVRCrowdsale is CappedCrowdSale, RefundableCrowdSale {
  enum CrowdsaleStage {PreICO, ICO}
  CrowdsaleStage public stage = CrowdsaleStage.PreICO;

  uint public maxTokens = 400000000000000000000000000;
  uint public totalTokensForSale = 260000000000000000000000000;
  uint public totalTokensForPreSale = 80000000000000000000000000;
  uint public tokensForTeam = 60000000000000000000000000;
  uint public tokensForBounty = 4000000000000000000000000;

  uint public totalWeiRaisedDuringPreICO;

  event EthTransferred (string text);
  event EthRefunded (string text);
}