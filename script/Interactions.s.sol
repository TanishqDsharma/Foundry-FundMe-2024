//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script,console} from "../lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";
import {DevOpsTools} from  "../lib/foundry-devops/src/DevOpsTools.sol";


contract FundMe_FundInteraction is Script {


    function fundFundMe(address mostRecentlyDeployed) public {
        uint256  SEND_VALUE = 1e18;
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded Fund me with ETH");
    }

    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();


    }
   



} 

contract FundMe_WithdrawInteraction is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        uint256  SEND_VALUE = 1e18;
        vm.startBroadcast();
 FundMe(payable(mostRecentlyDeployed)).withdraw();        vm.stopBroadcast();
       
        console.log("ETH withdrawed to wallet");
    }

    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();


    }
}