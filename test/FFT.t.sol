// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {FFT} from "../src/fft.sol";
import "../src/complexMath/Trigonometry.sol";

contract FFTTest is Test, FFT {
    FFT public fft;

    function setUp() public {
        fft = new FFT();
    }

    // // function test_bitReverse() public {
    // //     uint8[8] memory ans = [0, 4, 2, 6, 1, 5, 3, 7];
    // //     for (uint i = 0; i < 8; i++) {
    // //         uint x = fft.bitReverse(i, 3);
    // //         assertEq(x, ans[i]);
    // //     }
    // // }
    // // function test_fft() public {
    // //     Complex[8] memory a = [
    // //         Complex(0, 0),
    // //         Complex(1, 1),
    // //         Complex(2, 2),
    // //         Complex(3, 3),
    // //         Complex(3, 3),
    // //         Complex(2, 2),
    // //         Complex(1, 1),
    // //         Complex(0, 0)
    // //     ];
    // //     Complex[8] memory ans = fft.fft(a, 3);
    // //     assertEq(ans[0].re, 16);
    // //     assertEq(ans[0].im, 16);
    // // }
    function test_finalFFT() public {
        int[8] memory re = [int(0), 1, 3, 4, 4, 3, 1, 0];
        int[8] memory im = [int(0), 1, 3, 4, 4, 3, 1, 0];
        for (uint i = 0; i < 8; i++) {
            re[i] *= 1e18;
            im[i] *= 1e18;
        }
        (re, im) = fft.finalFFT(re, im, 3);
        assertEq(re[0] / 1e18, 16);
        assertEq(im[0] / 1e18, 16);
    }
    // // function test_trig() public {
    // //     int sinVal = Trigonometry.sin(15707963267948966150);
    // //     int cosVal = Trigonometry.cos(0);
    // //     assertEq(sinVal, cosVal);
    // // }
}
