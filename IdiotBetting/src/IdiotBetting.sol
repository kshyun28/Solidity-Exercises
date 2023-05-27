// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */
    uint256 public endTime;
    uint256 public highestDeposit;
    address public winner;

    constructor() {
        endTime = block.timestamp + 1 hours;
    }

    function bet() public payable {
        require(block.timestamp < endTime, "betting period is over");
        if (msg.value > highestDeposit) {
            highestDeposit = msg.value;
            winner = msg.sender;
            endTime = block.timestamp + 1 hours;
        }
    }

    function claimPrize() public {
        require(block.timestamp > endTime, "betting period is not over");
        require(msg.sender == winner, "only the winner can claim the prize");
        msg.sender.call{value: viewBalance()}("");
    }

    function viewBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
