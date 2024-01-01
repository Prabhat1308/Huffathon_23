// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "foundry-huff/HuffDeployer.sol";
import {FFT} from "../src/FFT_implementation/fft.sol";
import "../src/complexMath/Trigonometry.sol";
import "forge-std/console.sol";

contract FFTTest is Test {
    FFT public fft;
    Wrapper public fft_huff;
    int256[] real_part;
    int256[] complex_part;
    int256 constant SCALE = 1e18;

    function setUp() public {
        fft = new FFT();
        fft_huff = Wrapper(HuffDeployer.deploy("FFT_implementation/Wrapper"));
    }

    function test_finalFFT1() public {
        real_part.push((int256(1) * 1e18));
        real_part.push(-1 * 1e18);
        real_part.push(0 * 1e18);
        real_part.push(0 * 1e18);
        complex_part.push(int256(0) * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(1 * 1e18);
        complex_part.push(-1 * 1e18);
        int256[] memory re;
        int256[] memory im;
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

    function test_finalFFT2() public {
        real_part.push(1 * 1e18);
        real_part.push(-1 * 1e18);
        real_part.push(0 * 1e18);
        real_part.push(0 * 1e18);
        real_part.push(1 * 1e18);
        real_part.push(2 * 1e18);
        real_part.push(3 * 1e18);
        real_part.push(2 * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(1 * 1e18);
        complex_part.push(-1 * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(1 * 1e18);
        complex_part.push(3 * 1e18);
        complex_part.push(0 * 1e18);
        assertEq(real_part.length, 8);
        int256[] memory re;
        int256[] memory im;
        (re, im) = fft.fft(real_part, complex_part);
        assertApproxEqAbs(re[0], 8 * 1e18, 1e15);
        assertApproxEqAbs(im[0], 4 * 1e18, 1e15);
        assertApproxEqAbs(re[1], -4.121 * 1e18, 1e15);
        assertApproxEqAbs(im[1], 6.535 * 1e18, 1e15);
        assertApproxEqAbs(re[2], 1 * 1e18, 1e15);
        assertApproxEqAbs(im[2], -3 * 1e18, 1e15);
        assertApproxEqAbs(re[3], 1.292 * 1e18, 1e15);
        assertApproxEqAbs(im[3], 0.535 * 1e18, 1e15);
        assertApproxEqAbs(re[4], 2 * 1e18, 1e15);
        assertApproxEqAbs(im[4], 4 * 1e18, 1e15);
        assertApproxEqAbs(re[5], 0.1213 * 1e18, 1e15);
        assertApproxEqAbs(im[5], -0.5355 * 1e18, 1e15);
        assertApproxEqAbs(re[6], -3 * 1e18, 1e15);
        assertApproxEqAbs(im[6], -5 * 1e18, 1e15);
        assertApproxEqAbs(re[7], 2.7071 * 1e18, 1e15);
        assertApproxEqAbs(im[7], -6.5355 * 1e18, 1e15);
    }

    function test_trig() public {
        int256 sinVal = Trigonometry.sin(1570796326794896615);
        int256 cosVal = Trigonometry.cos(0);
        assertApproxEqAbs(sinVal, cosVal, 1e15);
    }

    function test_fft_in_huff1() public {
        real_part.push(1 * 1e18);
        real_part.push(-1 * 1e18);
        real_part.push(0 * 1e18);
        real_part.push(0 * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(1 * 1e18);
        complex_part.push(-1 * 1e18);
        int256[] memory re;
        int256[] memory im;
        (re, im) = fft_huff.fft(real_part, complex_part);
        assertApproxEqAbs(re[0], 0 * 1e18, 1e15);
        assertApproxEqAbs(im[0], 0 * 1e18, 1e15);
        assertApproxEqAbs(re[1], 2 * 1e18, 1e15);
        assertApproxEqAbs(im[1], 0 * 1e18, 1e15);
        assertApproxEqAbs(re[2], 2 * 1e18, 1e15);
        assertApproxEqAbs(im[2], 2 * 1e18, 1e15);
        assertApproxEqAbs(re[3], 0 * 1e18, 1e15);
        assertApproxEqAbs(im[3], -2 * 1e18, 1e15);
    }

    function test_fft_in_huff2() public {
        real_part.push(1 * 1e18);
        real_part.push(-1 * 1e18);
        real_part.push(0 * 1e18);
        real_part.push(0 * 1e18);
        real_part.push(1 * 1e18);
        real_part.push(2 * 1e18);
        real_part.push(3 * 1e18);
        real_part.push(2 * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(1 * 1e18);
        complex_part.push(-1 * 1e18);
        complex_part.push(0 * 1e18);
        complex_part.push(1 * 1e18);
        complex_part.push(3 * 1e18);
        complex_part.push(0 * 1e18);
        assertEq(real_part.length, 8);
        int256[] memory re;
        int256[] memory im;
        (re, im) = fft_huff.fft(real_part, complex_part);
        assertApproxEqAbs(re[0], 8 * 1e18, 1e15);
        assertApproxEqAbs(im[0], 4 * 1e18, 1e15);
        assertApproxEqAbs(re[1], -4.121 * 1e18, 1e15);
        assertApproxEqAbs(im[1], 6.535 * 1e18, 1e15);
        assertApproxEqAbs(re[2], 1 * 1e18, 1e15);
        assertApproxEqAbs(im[2], -3 * 1e18, 1e15);
        assertApproxEqAbs(re[3], 1.292 * 1e18, 1e15);
        assertApproxEqAbs(im[3], 0.535 * 1e18, 1e15);
        assertApproxEqAbs(re[4], 2 * 1e18, 1e15);
        assertApproxEqAbs(im[4], 4 * 1e18, 1e15);
        assertApproxEqAbs(re[5], 0.1213 * 1e18, 1e15);
        assertApproxEqAbs(im[5], -0.5355 * 1e18, 1e15);
        assertApproxEqAbs(re[6], -3 * 1e18, 1e15);
        assertApproxEqAbs(im[6], -5 * 1e18, 1e15);
        assertApproxEqAbs(re[7], 2.7071 * 1e18, 1e15);
        assertApproxEqAbs(im[7], -6.5355 * 1e18, 1e15);
    }
}

interface Wrapper {
    function fft(int256[] memory, int256[] memory) external returns (int256[] memory, int256[] memory);
}
