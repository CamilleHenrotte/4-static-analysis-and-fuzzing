// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import {Dex, SwappableToken} from "../src/Dex.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployDex is Script {
    address public immutable ATTACKER = makeAddr("attacker");

    function run() public returns (Dex) {
        vm.startBroadcast();
        Dex dex = new Dex();
        vm.prank(ATTACKER);
        SwappableToken token1 = new SwappableToken(
            address(dex),
            "Token 1",
            "T1",
            110
        );
        vm.prank(ATTACKER);
        SwappableToken token2 = new SwappableToken(
            address(dex),
            "Token 2",
            "T2",
            110
        );
        vm.prank(ATTACKER);
        token1.transfer(dex.address, 100);
        vm.prank(ATTACKER);
        token2.transfer(dex.address, 100);
        dex.setTokens(token1, token2);
        vm.stopBroadcast();
        return dex;
    }
}
