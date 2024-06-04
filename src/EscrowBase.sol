// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EscrowBase {
    address public buyer;
    address public seller;
    address public inspector;

    modifier onlyBuyer() {
        require(msg.sender == buyer, "You are not the buyer");
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller, "You are not the seller");
        _;
    }

    modifier onlyInspector() {
        require(msg.sender == inspector, "You are not the inspector");
        _;
    }

    constructor() payable {
        require(msg.value > 0, "Escrow is not correctly set");
    }
}
