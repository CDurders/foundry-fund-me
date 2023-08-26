// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { FundMe } from "../src/FundMe.sol";

contract FundFundMe is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(mostRecentlyDeployed);
    }

    function fundFundMe(address mostRecentDeployment) public {
        uint256 SEND_VALUE = 0.01 ether;
        vm.startBroadcast();
        FundMe(payable(mostRecentDeployment)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }
}

contract WithdrawFundMe is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(mostRecentlyDeployed);
    }

    function withdrawFundMe(address mostRecentDeployment) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentDeployment)).withdraw();
        vm.stopBroadcast();
    }
}