pragma solidity ^0.8.0;
import {TokenWhaleChallenge} from "./TokenWhaleChallenge.sol";

contract TestTokenWhaleChallenge is TokenWhaleChallenge {
    address echidna = msg.sender;

    constructor() TokenWhaleChallenge(echidna) {}

    function echidna_test_isComplete() public view returns (bool) {
        return super.isComplete();
    }
}
