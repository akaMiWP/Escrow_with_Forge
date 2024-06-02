// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Escrow} from "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;

    address buyer = address(2);
    address seller = address(3);
    address inspector = address(4);

    function setUp() public {
        hoax(buyer);
        escrow = new Escrow{value: 1 ether}(seller, inspector);
    }

    function testConfirmOrderPassedUsingSeller() public {
        vm.prank(seller);
        Escrow.Shipping memory shipping = Escrow.Shipping(true, "1234");
        escrow.confirmOrder(shipping);
        (bool isOrderCompleted, string memory shippingAddreess) = escrow
            .shipping();
        assertEq(shipping.isOrderCompleted, isOrderCompleted);
        assertEq(shipping.shippingAddress, shippingAddreess);
    }
}
