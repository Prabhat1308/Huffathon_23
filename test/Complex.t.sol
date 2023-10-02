// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ComplexTest is Test {
    Complex public complex;
    int scale = 10e18;

    function setUp() public {
        address com = HuffDeployer.config().deploy("ComplexHuff/Complex");
        complex = Complex(com);
    }

    // input re(a), re(b), im(a), im(b)
    // most gas efficient permutation
    function testAddZ() public {
        (int256 r, int256 i) = complex.addZ(
            int(1) * scale,
            int(2) * scale,
            int(3) * scale,
            int(4) * scale
        );
        assertEq(r / scale, 3);
        assertEq(i / scale, 7);
    }

    function testSubZ() public {
        (int256 r, int256 i) = complex.subZ(
            3 * scale,
            2 * scale,
            5 * scale,
            1 * scale
        );
        assertEq(r / scale, 1);
        assertEq(i / scale, 4);
    }

    function testMulZ() public {
        (int256 r, int256 i) = complex.addZ(
            1 * scale,
            3 * scale,
            1 * scale,
            2 * scale
        );
        assertEq(r / scale, 1);
        assertEq(i / scale, 5);
    }

    function testDivZ() public {
        (int256 r, int256 i) = complex.divZ(
            7 * scale,
            1 * scale,
            5 * scale,
            2 * scale
        );
        assertEq((r * 10) / scale, 34); // 17/5
        assertEq((i * 10) / scale, -16); // -8/5
    }

    function testCalcR() public {
        uint r = complex.calcR(3 * scale, 4 * scale);
        assertEq(r / uint(scale), 5);
    }

    function testToPolar() public {
        (int r, int t) = complex.toPolar(3 * scale, 4 * scale);
        assertEq(r / scale, 5); // r = 5
        assertEq((t * 100) / scale, 92); // T = arctan(4/3) == 0.92 rad
    }

    function testFromPolar() public {
        (int r, int i) = complex.fromPolar(5 * scale, 92729522 * 1e10);
        assertApproxEqAbs(r, 3 * scale, 1e15);
        assertApproxEqAbs(i, 4 * scale, 1e15);
    }
}

interface Complex {
    function addZ(
        int256,
        int256,
        int256,
        int256
    ) external returns (int256, int256);

    function subZ(
        int256,
        int256,
        int256,
        int256
    ) external returns (int256, int256);

    function mulZ(
        int256,
        int256,
        int256,
        int256
    ) external returns (int256, int256);

    function divZ(
        int256,
        int256,
        int256,
        int256
    ) external returns (int256, int256);

    function calcR(int256, int256) external returns (uint256);

    function toPolar(int256, int256) external returns (int256, int256);

    function fromPolar(int256, int256) external returns (int256, int256);

    function p_atan2(int256, int256) external returns (int256);

    function atan1to1(int256) external returns (int256);

    function ln(int256, int256) external returns (int256);

    function sqrt(int256, int256) external returns (int256);

    function expZ(int256, int256) external returns (int256, int256);

    function pow(int256, int256, int256) external returns (int256, int256);
}
