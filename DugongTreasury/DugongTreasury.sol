//SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

interface Token {
    function approve(address spender, uint256 amount) external returns(bool);
    function transfer(address recipient, uint256 amount) external returns(bool);
}

contract DugongTreasury {

    address private owner;

    constructor() {
        owner = address(0xbaa1374EA7F5390540A24809Aa90b29512b2AAf2);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You're not the owner.");
        _;
    }

    receive() external payable {
    }

    function sendEther(address recipient, uint256 amount) onlyOwner external returns(bool) {
        payable(recipient).transfer(amount);
        return true;
    }

    function sendToken(address tokenAddress, address recipient, uint256 amount) onlyOwner external returns(bool) {
        Token(tokenAddress).transfer(recipient, amount);
        return true;
    }

    function approveToken(address tokenAddress, address spender, uint256 amount) onlyOwner external returns(bool) {
        Token(tokenAddress).approve(spender, amount);
        return true;
    }
}
