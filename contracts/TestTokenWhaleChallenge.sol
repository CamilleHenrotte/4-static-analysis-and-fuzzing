pragma solidity =0.4.25;
import {TokenWhaleChallenge} from "./TokenWhaleChallenge.sol";

contract TestTokenWhaleChallenge is TokenWhaleChallenge {
    address echidna = msg.sender;
    function TestTokenWhaleChallenge() public TokenWhaleChallenge(echidna) {}
    function echidna_test_isComplete() public view returns (bool) {
        return super.isComplete();
    }
}
