// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    mapping(address => uint256) public buyerBalance;
    mapping(address => uint256) public buyerDepositDate;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        require(
            buyerBalance[msg.sender] == 0,
            "buyer has an active escrow or seller hasn't withdrawn yet"
        );
        buyerBalance[msg.sender] = msg.value;
        buyerDepositDate[msg.sender] = block.timestamp;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        require(msg.sender == seller, "only seller can withdraw");
        require(
            block.timestamp > buyerDepositDate[buyer] + 3 days,
            "cannot withdraw before 3 days has passed"
        );
        msg.sender.call{value: buyerBalance[buyer]}("");
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(
            block.timestamp < buyerDepositDate[msg.sender] + 3 days,
            "cannot withdraw after 3 days has passed"
        );
        require(
            buyerBalance[msg.sender] > 0,
            "buyer does not have a balance to withdraw"
        );
        msg.sender.call{value: buyerBalance[msg.sender]}("");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        return buyerBalance[buyer];
    }
}
