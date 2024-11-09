// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import {TokenWhaleChallenge} from "../src/TokenWhaleChallenge.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployTokenWhaleChallenge is Script {
    address public immutable ATTACKER = makeAddr("attacker");
    function run() public returns (TokenWhaleChallenge) {
        vm.startBroadcast();
        TokenWhaleChallenge token = new TokenWhaleChallenge(ATTACKER);
        vm.stopBroadcast();
        return token;
    }
}
