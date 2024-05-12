//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {FundMe} from "../../src/FundMe.sol";
import {Test,console} from "../../lib/forge-std/src/Test.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundMe_FundInteraction, FundMe_WithdrawInteraction} from "../../script/Interactions.s.sol";
contract InteractionsTest is Test{
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1e18;

    function setUp() external{
         DeployFundMe deployFundMe = new DeployFundMe();
         fundMe = deployFundMe.run();
         vm.deal(USER,10e18);
    }

    function testUserCanFund() public {
        FundMe_FundInteraction fundMe_FundInteraction = new FundMe_FundInteraction();
        fundMe_FundInteraction.fundFundMe(address(fundMe));
        FundMe_WithdrawInteraction fundMe_WithdrawInteraction = new FundMe_WithdrawInteraction();
        fundMe_WithdrawInteraction.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);


        
    }


}