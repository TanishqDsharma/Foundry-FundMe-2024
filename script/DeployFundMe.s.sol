//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract DeployFundMe is Script{
    
    function run() external returns (FundMe){
        HelperConfig helperConfig = new HelperConfig();
        (address ETHUSD_PriceFeed) = helperConfig.activeNetworkConfig();
        FundMe fundme;
        vm.startBroadcast();
        fundme = new FundMe(ETHUSD_PriceFeed);
        vm.stopBroadcast();
        return fundme;
    }



}