// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract WhoCalledMe {
    address public caller;

    function callMe() public {
        caller = msg.sender;
    }
}
