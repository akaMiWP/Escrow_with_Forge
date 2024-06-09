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

    modifier escrowNotBeCompleted() {
        require(!isEscrowCompleted, "Escrow has been completed");
        _;
    }

    constructor(address _seller, address _inspector) payable {
        buyer = msg.sender;
        seller = _seller;
        inspector = _inspector;
        productPrice = msg.value;
    }

    function confirmOrder(
        Shipping calldata _shipping
    ) external onlySeller escrowNotBeCompleted {
        shipping = _shipping;
    }

    function completeEscrow() external onlyInspector escrowNotBeCompleted {
        require(shipping.isOrderCompleted, "An order hasn't been completed");
        (bool s, ) = seller.call{value: productPrice}("");
        require(s, "Unable to send money");
        isEscrowCompleted = true;
    }
}
