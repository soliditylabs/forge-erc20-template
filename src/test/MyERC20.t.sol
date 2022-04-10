// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Vm} from "forge-std/Vm.sol";
import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage} from "forge-std/stdlib.sol";

// custom DSTest with public functions instead of ds-test
import {DSTest} from "./utils/test.sol";
import {Utils} from "./utils/Utils.sol";
import {MyERC20} from "../MyERC20.sol";

contract BaseSetup is MyERC20, DSTest {
    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    StdStorage internal stdstore;

    Utils internal utils;
    address payable[] internal users;

    address internal alice;
    address internal bob;

    function setUp() public virtual {
        utils = new Utils();
        users = utils.createUsers(5);

        alice = users[0];
        vm.label(alice, "Alice");
        bob = users[1];
        vm.label(bob, "Bob");
    }
}

contract WhenTransferringTokens is BaseSetup {
    uint256 internal maxTransferAmount = 12e18;

    function setUp() public virtual override {
        BaseSetup.setUp();
        console.log("When transferring tokens");
    }
}

contract WhenAliceHasInsufficientFunds is WhenTransferringTokens {
    uint256 internal mintAmount = maxTransferAmount - 1e18;

    function setUp() public override {
        WhenTransferringTokens.setUp();
        console.log("When Alice has insufficient funds");
        _mint(alice, mintAmount);
    }
}

contract WhenAliceHasSufficientFunds is WhenTransferringTokens {
    using stdStorage for StdStorage;
    uint256 internal mintAmount = maxTransferAmount;

    function setUp() public override {
        WhenTransferringTokens.setUp();
        console.log("When Alice has sufficient funds");
        _mint(alice, mintAmount);
    }

    // example how to use https://github.com/brockelmore/forge-std stdStorage
    function testFindMapping() public {
        uint256 slot = stdstore
            .target(address(this))
            .sig(this.balanceOf.selector)
            .with_key(alice)
            .find();
        bytes32 data = vm.load(address(this), bytes32(slot));
        assertEq(uint256(data), mintAmount);
    }
}

function transferToken(
    address alice,
    address bob,
    Vm vm,
    WhenTransferringTokens myTestERC20,
    uint256 transferAmount
) returns (bool) {
    vm.prank(alice);
    return myTestERC20.transfer(bob, transferAmount);
}

function itTransfersAmountCorrectly(
    address alice,
    address bob,
    Vm vm,
    WhenTransferringTokens myTestERC20,
    uint256 transferAmount
) {
    uint256 aliceBalanceBefore = myTestERC20.balanceOf(alice);
    bool success = transferToken(alice, bob, vm, myTestERC20, transferAmount);

    myTestERC20.assertTrue(success);
    myTestERC20.assertEq(
        myTestERC20.balanceOf(alice),
        aliceBalanceBefore - transferAmount
    );
    myTestERC20.assertEq(myTestERC20.balanceOf(bob), transferAmount);
}

function itRevertsTransfer(
    address alice,
    address bob,
    Vm vm,
    WhenTransferringTokens myTestERC20,
    uint256 transferAmount,
    string memory expectedRevertMessage
) {
    vm.expectRevert(abi.encodePacked(expectedRevertMessage));
    transferToken(alice, bob, vm, myTestERC20, transferAmount);
}

contract TransferSuccess is WhenAliceHasSufficientFunds {
    function testTransferAllTokens() public {
        itTransfersAmountCorrectly(alice, bob, vm, this, maxTransferAmount);
    }

    function testTransferHalfTokens() public {
        itTransfersAmountCorrectly(alice, bob, vm, this, maxTransferAmount / 2);
    }

    function testTransferOneToken() public {
        itTransfersAmountCorrectly(alice, bob, vm, this, 1);
    }

    function testTransferWithMockedCall() public {
        vm.prank(alice);
        vm.mockCall(
            address(this),
            abi.encodeWithSelector(
                this.transfer.selector,
                bob,
                maxTransferAmount
            ),
            abi.encode(false)
        );
        bool success = this.transfer(bob, maxTransferAmount);
        assertTrue(!success);
        vm.clearMockedCalls();
    }
}

contract TransferRevert is WhenAliceHasInsufficientFunds {
    function testCannotTransferMoreThanAvailable() public {
        itRevertsTransfer({
            alice: alice,
            bob: bob,
            vm: vm,
            myTestERC20: this,
            transferAmount: maxTransferAmount,
            expectedRevertMessage: "ERC20: transfer amount exceeds balance"
        });
    }

    function testCannotTransferToZero() public {
        itRevertsTransfer({
            alice: alice,
            bob: address(0),
            vm: vm,
            myTestERC20: this,
            transferAmount: mintAmount,
            expectedRevertMessage: "ERC20: transfer to the zero address"
        });
    }
}
