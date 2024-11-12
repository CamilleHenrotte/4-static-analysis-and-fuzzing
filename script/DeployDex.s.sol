// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import {Dex, SwappableToken} from "../src/Dex.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployDex is Script {
    address public immutable ATTACKER = makeAddr("attacker");

    function run() public returns (Dex) {
        vm.startBroadcast();

        // Deploy the Dex contract
        Dex dex = new Dex();

        // Deploy two SwappableToken contracts with initial supply
        SwappableToken token1 = new SwappableToken(
            address(dex),
            "Token 1",
            "T1",
            110 ether
        );

        SwappableToken token2 = new SwappableToken(
            address(dex),
            "Token 2",
            "T2",
            110 ether
        );

        // Set tokens for the Dex contract
        dex.setTokens(address(token1), address(token2));

        // Transfer initial liquidity to Dex contract
        token1.transfer(address(dex), 100 ether);
        token2.transfer(address(dex), 100 ether);
        token1.transfer(ATTACKER, 10 ether);
        token2.transfer(ATTACKER, 10 ether);

        vm.stopBroadcast();

        return dex;
    }
}
