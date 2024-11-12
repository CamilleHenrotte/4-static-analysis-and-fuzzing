// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {DeployDex} from "../script/DeployDex.s.sol";
import {Dex, SwappableToken} from "../src/Dex.sol";

contract TestDex is Test {
    address public immutable ATTACKER = makeAddr("attacker");
    Dex public dex;

    function setUp() public {
        DeployDex deploy = new DeployDex();
        dex = deploy.run();
    }
    function test_initialize_state() public {
        assertEq(dex.token1, token1.address);
        assertEq(dex.token2, token2.address);
        assertEq(dex.balanceOf(token1.address, address(dex)), 100);
        assertEq(dex.balanceOf(token2.address, address(dex)), 100);
        assertEdq(dex.balanceOf(token1.address, ATTACKER), 10);
        assertEq(dex.balanceOf(token2.address, ATTACKER), 10);
    }
    function test_attack() public {}
}
