// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./EscrowBase.sol";

contract Escrow is EscrowBase {
    struct Shipping {
        bool isOrderCompleted;
        string shippingAddress;
    }

    Shipping public shipping;
    bool public isEscrowCompleted;
    uint public productPrice;

    constructor(address _seller, address _inspector) payable {
        buyer = msg.sender;
        seller = _seller;
        inspector = _inspector;
        productPrice = msg.value;
        require(msg.value > 0, "Escrow is not correctly set");
    }

    function confirmOrder(Shipping calldata _shipping) external onlySeller {
        require(!isEscrowCompleted, "Escrow has been completed");
        shipping = _shipping;
    }

    function completeEscrow() external onlyInspector {
        require(!isEscrowCompleted, "Escrow has been completed");
        require(shipping.isOrderCompleted, "An order hasn't been completed");
        (bool s, ) = seller.call{value: productPrice}("");
        require(s, "Unable to send money");
        isEscrowCompleted = true;
    }
}
