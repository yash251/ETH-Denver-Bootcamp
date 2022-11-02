// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    uint256 public totalSupply = 10000;
    address public owner;

    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    modifier onlyOwner() {
        if (owner == msg.sender) {
            _;
        }
    }

    struct Payment {
        uint256 transferAmount;
        address recipient;
    }

    event totalSupplyChanged(uint256);
    event tokenTransferred(uint256 amountTransferred, address recipient);

    mapping(address => uint256) public balances;
    mapping(address => Payment) public paymentList;

    function changeTotalSupply() public onlyOwner {
        totalSupply = totalSupply + 1000;
        emit totalSupplyChanged(totalSupply);
    }

    function transferToken(uint256 _amount, address _recipient) public {
        balances[_recipient] = balances[_recipient] + _amount;
        balances[msg.sender] = balances[msg.sender] - _amount;
        emit tokenTransferred(_amount, _recipient);
        paymentList[msg.sender] = Payment(_amount, _recipient);
    }
}
