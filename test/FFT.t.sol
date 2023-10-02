// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {FFT} from "../src/FFT_implementation/fft.sol";
import "../src/complexMath/Trigonometry.sol";

contract FFTTest is Test {
    // FFT public fft;
    // function setUp() public {
    //     fft = new FFT();
    // }
    // function test_finalFFT() public {
    //     int[] memory real_part;
    //     (real_part[0], real_part[1], real_part[2], real_part[3]) = (
    //         int(1) * 1e18,
    //         -1 * 1e18,
    //         0 * 1e18,
    //         0 * 1e18
    //     );
    //     int[] memory complex_part;
    //     (complex_part[0], complex_part[1], complex_part[2], complex_part[3]) = (
    //         int(0) * 1e18,
    //         0 * 1e18,
    //         1 * 1e18,
    //         -1 * 1e18
    //     );
    //     int[] memory re;
    //     int[] memory im;
    //     (re, im) = fft.fft(real_part, complex_part);
    //     assertEq(re[0] / 1e18, 0);
    //     assertEq(im[0] / 1e18, 0);
    // }
    // // function test_trig() public {
    // //     int sinVal = Trigonometry.sin(15707963267948966150);
    // //     int cosVal = Trigonometry.cos(0);
    // //     assertEq(sinVal, cosVal);
    // // }
}
