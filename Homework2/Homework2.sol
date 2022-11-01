// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "./BootcampContract.sol";

contract Homework2 {
    BootcampContract bc = new BootcampContract();

    function setNum(uint256 _num) public {
        bc.store(_num);
    }

    function getNum() public view returns (uint256) {
        return bc.retrieve();
    }
}
