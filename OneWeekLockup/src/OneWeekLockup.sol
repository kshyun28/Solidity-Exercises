// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */
    mapping(address => uint256) public balances;
    mapping(address => uint256) public lastDeposit;

    function balanceOf(address user) public view returns (uint256) {
        return balances[user];
    }

    function depositEther() external payable {
        balances[msg.sender] += msg.value;
        lastDeposit[msg.sender] = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
        require(
            amount <= balances[msg.sender],
            "withdraw amount is greater than balance"
        );
        require(
            block.timestamp >= lastDeposit[msg.sender] + 1 weeks,
            "withdrawal must be 1 week after last deposit"
        );

        msg.sender.call{value: amount}("");
    }
}
