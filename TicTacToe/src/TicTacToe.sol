// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
    /* 
        This exercise assumes you know how to manipulate nested array.
        1. This contract checks if TicTacToe board is winning or not.
        2. Write your code in `isWinning` function that returns true if a board is winning
           or false if not.
        3. Board contains 1's and 0's elements and it is also a 3x3 nested array.
    */

    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        // Horizontal
        bool cond1 = board[0][0] == board[0][1] && board[0][0] == board[0][2];
        bool cond2 = board[1][0] == board[1][1] && board[1][0] == board[1][2];
        bool cond3 = board[2][0] == board[2][1] && board[2][0] == board[2][2];
        // Vertical
        bool cond4 = board[0][0] == board[1][0] && board[0][0] == board[2][0];
        bool cond5 = board[0][1] == board[1][1] && board[0][1] == board[2][1];
        bool cond6 = board[0][2] == board[1][2] && board[0][2] == board[2][2];
        // Diagonal
        bool cond7 = board[0][0] == board[1][1] && board[0][0] == board[2][2];
        bool cond8 = board[0][2] == board[1][1] && board[0][2] == board[2][0];

        if (
            cond1 || cond2 || cond3 || cond4 || cond5 || cond6 || cond7 || cond8
        ) {
            return true;
        }
        return false;
    }
}
