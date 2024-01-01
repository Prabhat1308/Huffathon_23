// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "foundry-huff/HuffDeployer.sol";
import {PRBMathSD59x18} from "../src/complexMath/prbMath/PRBMathSD59x18.sol";
import "forge-std/console.sol";

contract PRBMathtest is Test {
    Wrapper public prb_huff;
    int256 constant SCALE = 1e18;

    function setUp() public {
        prb_huff = Wrapper(HuffDeployer.deploy("ComplexHuff/PRBMathWrapper"));
    }

    // function test_sqrt(int256 num) public {
    //     vm.assume(num > 0);
    //     assertApproxEqAbs(PRBMathSD59x18.log2(num), prb_huff.log_2(num), 0);
    // }

    function testFuzz_ln(int256 num) public {
        vm.assume(num > 0);
        assertApproxEqAbs(PRBMathSD59x18.ln(num), prb_huff.ln(num), 0);
    }

    function testFuzz_log_2(int256 num) public {
        vm.assume(num > 0);
        assertApproxEqAbs(PRBMathSD59x18.log2(num), prb_huff.log_2(num), 0);
    }
}

interface Wrapper {
    function sqrt(int256) external returns (int256);
    function ln(int256) external returns (int256);
    function log_2(int256) external returns (int256);
}
