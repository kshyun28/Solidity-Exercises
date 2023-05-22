// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IsPrime {
    /**
     * The goal of this exercise is to return if "number" is prime or not (true or false)
     */
    function isPrime(uint256 number) public view returns (bool) {
        // 1 is a prime number
        if (number == 1) {
            return true;
        }

        uint256 factors = 0;
        for (uint256 i = 1; i <= number; i++) {
            if (number % i == 0) {
                factors += 1;
            }
        }

        // A prime number is a number that can only be divided by itself and 1 with no remainder
        if (factors == 2) {
            return true;
        } else {
            return false;
        }
    }
}
