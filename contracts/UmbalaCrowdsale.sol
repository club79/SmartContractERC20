pragma solidity ^0.4.18;

import './UmbalaToken.sol';
import '../zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import '../zeppelin-solidity/contracts/crowdsale/RefundableCrowdsale.sol';

contract UmbalaCrowdsale is CappedCrowdsale, RefundableCrowdsale {

  // ICO Stage
  // ============
  enum CrowdsaleStage { PreICO,PreSale1,PreSale2, ICO1, ICO2 }
  CrowdsaleStage public stage = CrowdsaleStage.PreICO; // By default it's Pre Sale
  // =============


  // Token Distribution
  // =============================
  uint256 public maxTokens = 200000000000000000000; // There will be total 100 Hashnode Tokens
  uint256 public tokensForDev = 20000000000000000000;
  uint256 public tokensForTeam = 10000000000000000000;
  uint256 public tokensForMarketing = 10000000000000000000;
  uint256 public totalTokensForSale = 160000000000000000000; // 160 HTs will be sold in Crowdsale
  uint256 public totalTokensForSaleDuringPreICO = 20000000000000000000; // 20 out of 60 HTs will be sold during PreICO

  // ==============================
  // ==============================

  // Amount raised in PreICO
  // ==================
  uint256 public totalWeiRaisedDuringPreICO;
  // ===================
  
  address public walletMarketing;


  // Events
  //event EthTransferred(string text);
  //event EthRefunded(string text);


  // Constructor
  // ============
  function UmbalaCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet, address _walletDev, address _walletMarketing, uint256 _goal, uint256 _cap) CappedCrowdsale(_cap) FinalizableCrowdsale() RefundableCrowdsale(_goal) Crowdsale(_startTime, _endTime, _rate, _wallet) public {
      require(_goal <= _cap);

      //Send token to owner
      //token.mint(_wallet, tokensForTeam);
      //Send token to dev
      //token.mint(_walletDev, tokensForDev);

      walletMarketing = _walletMarketing;
      //token.transferOwnership(owner);


      //Send token to marketing
      //token.mint(_walletMarketing, tokensForMarketing);
      //token.mint(walletMarketing, tokensForMarketing / 2);

  }
  // =============

  // Token Deployment
  // =================
  function createTokenContract() internal returns (MintableToken) {
    return new UmbalaToken();
  }


  // Pay for affiliate marketing programs
  function reward(address a, uint256 amount) public onlyOwner {
        require(a != address(0));
        token.mint(a, amount);
  } 


    //Owner call this function
    function lockToken() public onlyOwner {
        token.lock();
    }

    function unLockToken() public onlyOwner {
        token.unlock();
    }
  // ==================

  // Crowdsale Stage Management
  // =========================================================

  // Change Crowdsale Stage. Available Options: PreICO, ICO
  function setCrowdsaleStage(uint value) public onlyOwner {

      //CrowdsaleStage _stage;

      // if (uint(CrowdsaleStage.PreICO) == value) {
      //   _stage = CrowdsaleStage.PreICO;
      // } else if (uint(CrowdsaleStage.ICO) == value) {
      //   _stage = CrowdsaleStage.ICO;
      // }

      // stage = _stage;

      // if (stage == CrowdsaleStage.PreICO) {
      //   setCurrentRate(5);
      // } else if (stage == CrowdsaleStage.ICO) {
      //   setCurrentRate(2);
      // }
  }

  // Change the current rate
  function setCurrentRate(uint256 _rate) private {
      rate = _rate;
  }

  // ================ Stage Management Over =====================

  // Token Purchase
  // =========================
  function () external payable {
      // uint256 tokensThatWillBeMintedAfterPurchase = msg.value.mul(rate);
      // if ((stage == CrowdsaleStage.PreICO) && (token.totalSupply() + tokensThatWillBeMintedAfterPurchase > totalTokensForSaleDuringPreICO)) {
      //   msg.sender.transfer(msg.value); // Refund them
      //   EthRefunded("PreICO Limit Hit");
      //   return;
      // }

      buyTokens(msg.sender);

      // if (stage == CrowdsaleStage.PreICO) {
      //     totalWeiRaisedDuringPreICO = totalWeiRaisedDuringPreICO.add(msg.value);
      // }
  }

   function buyTokens(address add) public payable {
    
    //require(validPurchase());

    uint256 weiAmount = msg.value;

    // calculate token amount to be created
    uint256 tokens = weiAmount.mul(rate);

    // update state
    weiRaised = weiRaised.add(weiAmount);

    token.mint(add, tokens);

    TokenPurchase(msg.sender, add, weiAmount, tokens);

    forwardFunds();

  }

  function forwardFunds() internal {
      wallet.transfer(msg.value);
    //   if (stage == CrowdsaleStage.PreICO) {
    //       wallet.transfer(msg.value);
    //       EthTransferred("forwarding funds to wallet");
    //   } else if (stage == CrowdsaleStage.ICO) {
    //       EthTransferred("forwarding funds to refundable vault");
    //       super.forwardFunds();
    //   }
  }
  // ===========================

  // Finish: Mint Extra Tokens as needed before finalizing the Crowdsale.
  // ====================================================================

  // function finish(address _teamFund, address _ecosystemFund, address _bountyFund) public onlyOwner {

  //     require(!isFinalized);
  //     uint256 alreadyMinted = token.totalSupply();
  //     require(alreadyMinted < maxTokens);

  //     uint256 unsoldTokens = totalTokensForSale - alreadyMinted;
  //     if (unsoldTokens > 0) {
  //       tokensForEcosystem = tokensForEcosystem + unsoldTokens;
  //     }

  //     token.mint(_teamFund,tokensForTeam);
  //     token.mint(_ecosystemFund,tokensForEcosystem);
  //     token.mint(_bountyFund,tokensForBounty);
  //     finalize();
  // }


  function finalization() internal {
        // uint256 t = token.totalSupply();
        // uint256 extant = TOTAL_SUPPLY.sub(t);
        //ketThuc = true;
        // emit tokens for the foundation
        //token.mint(walletMarketing, tokensForMarketing / 2);

        super.finalization();
  }
  // ===============================

  // REMOVE THIS FUNCTION ONCE YOU ARE READY FOR PRODUCTION
  // USEFUL FOR TESTING `finish()` FUNCTION
  // function hasEnded() public view returns (bool) {
  //   return true;
  // }
}