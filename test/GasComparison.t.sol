// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";

// Contract using Modern Custom Errors
contract ModernContract {
    error InsufficientFunds(uint256 provided, uint256 required);
    
    function checkValue(uint256 val) public pure {
        if (val < 7 gwei) revert InsufficientFunds(val, 7 gwei);
    }
}

// Contract using Legacy Require Strings
contract LegacyContract {
    function checkValue(uint256 val) public pure {
        require(val >= 7 gwei, "Not enough ETH sent");
    }
}

contract GasComparisonTest is Test {
    ModernContract modern;
    LegacyContract legacy;

    function setUp() public {
        modern = new ModernContract();
        legacy = new LegacyContract();
    }

    // Measure success case (Passing the check)
    function test_Gas_Modern_Success() public view {
        modern.checkValue(10 gwei);
    }

    function test_Gas_Legacy_Success() public view {
        legacy.checkValue(10 gwei);
    }

    // Measure failure case (Reverting)
    function test_Gas_Modern_Revert() public {
        vm.expectRevert();
        modern.checkValue(1 gwei);
    }

    function test_Gas_Legacy_Revert() public {
        vm.expectRevert();
        legacy.checkValue(1 gwei);
    }
}
