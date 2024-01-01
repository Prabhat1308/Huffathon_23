// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ComplexTest is Test {
    WRAPPER public complex;
    int256 scale = 1e18;
    int256 scale2 = 1e19;

    function setUp() public {
        complex = WRAPPER(HuffDeployer.deploy("ComplexHuff/WRAPPER"));
    }

    function testSubZ() public {
        (int256 r, int256 i) = complex.subz(4 * scale, 5 * scale, 8 * scale, 11 * scale);
        assertEq(r / scale, 3);
        assertEq(i / scale, 1);
    }

    function testAddZ() public {
        (int256 r, int256 i) = complex.addz(2 * scale, 3 * scale, 4 * scale, 5 * scale);
        assertEq(r / scale, 9);
        assertEq(i / scale, 5);
    }

    function testMulZ() public {
        (int256 r, int256 i) = complex.mulz(2 * scale, 3 * scale, 4 * scale, 5 * scale);
        assertEq((r / scale) / scale, 14);
        assertEq((i / scale) / scale, 22);
    }

    function testDivZ() public {
        (int256 r, int256 i) = complex.divz(7 * scale, 1 * scale, 5 * scale, 2 * scale);
        assertEq((r * 10) / scale, 34); // 17/5
        assertEq((i * 10) / scale, -18); // -8/5
    }

    function testCalcR() public {
        uint256 r = complex.calcR(4, 4);
        assertEq(r * 100 / uint256(scale), 565);
    }

    function testToPolar() public {
        (int256 r, int256 t) = complex.toPolar(3, 4);
        assertEq(r / scale, 5);
        assertEq((t * 100) / scale, 65);
    }

    function testFromPolar() public {
        (int256 r, int256 i) = complex.fromPolar(5 * scale, 92729522 * 1e10);
        assertApproxEqAbs(r, 3 * scale, 1e15);
        assertApproxEqAbs(i, 4 * scale, 1e15);
    }

    function testSqrt() public {
        (int256 r, int256 i) = complex.sqrt(12, -5);
        assertEq(r / scale2, 2);
        assertEq(i / scale2, 3);
    }

    function testExpZ() public {
        (int256 r, int256 i) = complex.expZ(92729522 * 1e10, 1);
        assertApproxEqAbs(r, 1630800000000000000, 1e15);
        assertApproxEqAbs(i, 2174400000000000000, 1e15);
    }

    function testLnZ() public {
        (int256 r, int256 i) = complex.ln(30, 40);
        assertEq(r * 100 / scale, 391); // ln(50) = 3.912..
        assertEq(i * 100 / scale, 65);
    }

    function testPowZ() public {
        (int256 r, int256 i) = complex.pow(2, 3, 2);
        assertApproxEqAbs(r, -5 * scale, 5e17); // 5e17 i.e. roundoff precision upto whole no. (precision might inc if calcR is optimized)
        assertApproxEqAbs(i, 12 * scale, 1e17); // precision : upto 1 decimal point
    }
}

interface WRAPPER {
    function subz(int256, int256, int256, int256) external returns (int256, int256);

    function addz(int256, int256, int256, int256) external returns (int256, int256);

    function mulz(int256, int256, int256, int256) external returns (int256, int256);

    function divz(int256, int256, int256, int256) external returns (int256, int256);

    function calcR(int256, int256) external returns (uint256);

    function toPolar(int256, int256) external returns (int256, int256);

    function fromPolar(int256, int256) external returns (int256, int256);

    // function p_atan2(int256, int256) external returns (int256);

    // function atan1to1(int256) external returns (int256);

    function ln(int256, int256) external returns (int256, int256);

    function sqrt(int256, int256) external returns (int256, int256);

    function expZ(int256, int256) external returns (int256, int256);

    function pow(int256, int256, int256) external returns (int256, int256);
}
