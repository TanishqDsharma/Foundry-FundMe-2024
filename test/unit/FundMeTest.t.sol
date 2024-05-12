//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {FundMe} from "../../src/FundMe.sol";
import {Test,console} from "../../lib/forge-std/src/Test.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
FundMe fundMe;
address USER = makeAddr("user");
uint256 constant SEND_VALUE = 0.1e18;

    function setUp() external{
         DeployFundMe deployFundMe = new DeployFundMe();
         fundMe = deployFundMe.run();
         vm.deal(USER,10e18);
    }

    function testmininmumUSD () public view {
        assertEq(fundMe.MINIMUM_USD(),5e18);
    }

    function testcheck_owner () public view {
        console.log(msg.sender);
        console.log(address(this));
        assertEq(fundMe.get_owner(),msg.sender);
    }

    function testAggregatorVersion() public view{
        assertEq(fundMe.getVersion(),4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        fundMe.fund{value: 1e18}();
        uint256 amountFunded = fundMe.get_s_addressToAmountFunded(USER);
        assertEq(amountFunded,1e18);
    } 

    function testAddFunderstoArrayofFunders() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        address funder = fundMe.get_s_funders(0);
        assertEq(funder,USER);
    }

    modifier funded(){
        vm.prank(USER);
        fundMe.fund{value: 1e18}();    
        _;
        }

    function testOnlyOwnerCanWithdraw() public funded{
        
        vm.expectRevert();
        fundMe.withdraw();
        
    }

    

    

    function testWithdrawWithASingleFunder() public funded{
        uint256 startingOwnerBalance = fundMe.get_owner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.get_owner());
        fundMe.withdraw();

        uint256 endingOwnerBalance = fundMe.get_owner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;

        assertEq(endingFundMeBalance,0);
        assertEq(startingFundMeBalance+startingOwnerBalance,endingOwnerBalance);
    }


    function testWithdrawfromMultipleFundersWithdraw() public funded {
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for(uint160 i=startingFunderIndex;i<numberOfFunders;i++){
            hoax(address(i));
            fundMe.fund{value:SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.get_owner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.get_owner());
        fundMe.withdraw();

        assertEq(address(fundMe).balance,0);
        assertEq(startingFundMeBalance+startingOwnerBalance,fundMe.get_owner().balance);
    }


    function testWithdrawfromMultipleFundersCheaperWithdraw() public funded {
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for(uint160 i=startingFunderIndex;i<numberOfFunders;i++){
            hoax(address(i));
            fundMe.fund{value:SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.get_owner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.get_owner());
        fundMe.cheaperWithdraw();

        assertEq(address(fundMe).balance,0);
        assertEq(startingFundMeBalance+startingOwnerBalance,fundMe.get_owner().balance);
    }



}
