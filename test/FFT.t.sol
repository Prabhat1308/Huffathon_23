// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {FFT} from "../src/FFT_implementation/fft.sol";
import "../src/complexMath/Trigonometry.sol";

contract FFTTest is Test {
    FFT public fft;

    function setUp() public {
        fft = new FFT();
    }

    function test_finalFFT() public {
        int[4] memory real_part = [
            int(1) * 1e18,
            -1 * 1e18,
            0 * 1e18,
            0 * 1e18
        ];
        int[4] memory complex_part = [
            int(0) * 1e18,
            0 * 1e18,
            1 * 1e18,
            -1 * 1e18
        ];
        int[4] memory re;
        int[4] memory im;
        (re, im) = fft.fft(real_part, complex_part);
        assertApproxEqAbs(re[0], 0 * 1e18, 1e15);
        assertApproxEqAbs(im[0], 0 * 1e18, 1e15);
        assertApproxEqAbs(re[1], 2 * 1e18, 1e15);
        assertApproxEqAbs(im[1], 0 * 1e18, 1e15);
        assertApproxEqAbs(re[2], 2 * 1e18, 1e15);
        assertApproxEqAbs(im[2], 2 * 1e18, 1e15);
        assertApproxEqAbs(re[3], 0 * 1e18, 1e15);
        assertApproxEqAbs(im[3], -2 * 1e18, 1e15);
    }
    // // function test_trig() public {
    // //     int sinVal = Trigonometry.sin(15707963267948966150);
    // //     int cosVal = Trigonometry.cos(0);
    // //     assertEq(sinVal, cosVal);
    // // }
}
