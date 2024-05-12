//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Agg.sol";
contract HelperConfig is Script {

    NetworkConfig public activeNetworkConfig;
    uint8 public constant DECIMALS = 8;
    int256 public INITIAL_PRICE =2000e8;

    struct NetworkConfig{
        address priceFeed; // ETH/USD price feed address
    }

    constructor(){
        if(block.chainid==11155111){
            activeNetworkConfig = getSepoliaEthConfig();
        }
        else if(block.chainid==11155112){
            activeNetworkConfig = getArbConfig();
        }
        else {activeNetworkConfig=getAnvilConfig();}
    }

    function getSepoliaEthConfig() public  returns(NetworkConfig memory){
            NetworkConfig  memory sepoliaConfig = NetworkConfig ({
                priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
            });
            return sepoliaConfig;
    }

    function getArbConfig() public  returns (NetworkConfig memory){
        NetworkConfig memory arbConfig = NetworkConfig ({
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612
        });
        return arbConfig;
    }

    function getAnvilConfig() public  returns(NetworkConfig memory){
        if(activeNetworkConfig.priceFeed!=address(0)){
            return activeNetworkConfig;
        }
        vm.startBroadcast();
        MockV3Aggregator mockV3AggregatorFeed = new MockV3Aggregator(DECIMALS,INITIAL_PRICE);
        vm.stopBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig ({
            priceFeed: address(mockV3AggregatorFeed)
        });
        return anvilConfig;


    }
}