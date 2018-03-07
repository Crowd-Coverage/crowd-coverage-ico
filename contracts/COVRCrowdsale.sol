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

  function COVRCrowdSale(uint _startTime, uint _endTime, uint _rate, address _wallet, uint _goal, uint _cap) CappedCrowdsale(_cap) FinalizableCrowdsale() RefundableCrowdsale(_goal) Crowdsale(_startTime, _endTime, _rate, _wallet) public {
    require(_goal <= _cap);
  }

  function createCOVRContract() internal returns (MintableToken) {
    return new COVRToken();
  }

  function setCrowdSaleStage(uint value) public onlyOwner {
    CrowdsaleStage _stage;

    if(uint(CrowdsaleStage.PreICO) == value) {
      _stage = CrowdsaleStage.PreICO;
    } else if (uint(CrowdsaleStage.ICO) == value) {
      _stage = CrowdsaleStage.ICO;
    }

    stage = _stage;

    if(stage == CrowdsaleStage.PreICO) {
      setCurrentRate(6); // This will change before test
    } else if (stage == CrowdsaleStage.ICO) {
      setCurrentRate(3); // This will change before test
    }

    function setCurrentRate(uint _rate) private {
      rate = _rate;
    }
  }

    function () external payable {
      uint256 tokensThatWillBeMintedAfterPurchase = msg.value.mul(rate);
      if ((stage == CrowdsaleStage.PreICO) && (token.totalSupply() + tokensThatWillBeMintedAfterPurchase > totalTokensForSaleDuringPreICO)) {
        msg.sender.transfer(msg.value);
        EthRefunded("PreICO Limit Hit");
        return;
      }

      buyTokens(msg.sender);

      if (stage == CrowdsaleStage.PreICO) {
          totalWeiRaisedDuringPreICO = totalWeiRaisedDuringPreICO.add(msg.value);
      }
  }
}