// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./complexMath/Trigonometry.sol";

contract FFT {
    uint private constant PI = 31415926535897932384;

    function bitReverse(uint x, uint log2n) public pure returns (uint) {
        uint n = 0;
        for (uint i = 0; i < log2n; i++) {
            n <<= 1;
            n |= (x & 1);
            x >>= 1;
        }
        return n;
    }

    function mul(
        int reA,
        int imA,
        int reB,
        int imB
    ) public pure returns (int, int) {
        int a = ((reA * reB) - (imA * imB)) / 10e18;
        int b = ((reB * imA) + (reA * imB)) / 10e18;
        return (a, b);
    }

    function incFFT(
        int[8] memory re,
        int[8] memory im,
        uint log2n
    ) public pure returns (int[8] memory, int[8] memory) {
        int[8] memory re2;
        int[8] memory im2;
        uint256 n = 1 << log2n;
        for (uint i = 0; i < n; i++) {
            re2[bitReverse(i, log2n)] = re[i];
            im2[bitReverse(i, log2n)] = im[i];
        }
        for (uint s = 1; s <= log2n; s++) {
            uint256 m = 1 << s;
            uint256 m2 = m >> 1;
            int reW = 10e18;
            int imW = 0;
            int reWm = Trigonometry.cos(PI / m2);
            int imWm = -Trigonometry.sin(PI / m2);
            for (uint j = 0; j < m2; ++j) {
                for (uint k = j; k < n; k += m) {
                    int reT;
                    int imT;
                    (reT, imT) = mul(reW, imW, re2[k + m2], im2[k + m2]);
                    int reU = re2[k];
                    int imU = im2[k];
                    re2[k] = reU + reT;
                    im2[k] = imU + imT;
                    re2[k + m2] = reU - reT;
                    im2[k + m2] = imU - imT;
                }
                (reW, imW) = mul(reW, imW, reWm, imWm);
            }
        }
        return (re2, im2);
    }

    function finalFFT(
        int[8] memory re,
        int[8] memory im,
        uint256 log2n
    ) public pure returns (int[8] memory, int[8] memory) {
        uint size = 1 << log2n;
        uint k = size;
        uint n;
        uint angle = PI / size;
        int rePi = Trigonometry.cos(angle);
        int imPi = -Trigonometry.sin(angle);
        int reT;
        int imT;
        while (k > 1) {
            n = k;
            k >>= 1;
            (rePi, imPi) = mul(rePi, imPi, rePi, imPi);
            reT = 1e18;
            for (uint l = 0; l < k; l++) {
                for (uint a = l; a < size; a += n) {
                    uint b = a + k;
                    int reU = re[a] - re[b];
                    int imU = im[a] - im[b];
                    re[a] += re[b];
                    im[a] += im[b];
                    (re[b], im[b]) = mul(reU, imU, reT, imT);
                }
                (reT, imT) = mul(reT, imT, rePi, imPi);
            }
        }
        for (uint a = 0; a < size; a++) {
            uint b = a;
            b = (((b & 0xaaaaaaaa) >> 1) | ((b & 0x55555555) << 1));
            b = (((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2));
            b = (((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4));
            b = (((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8));
            b = ((b >> 16) | (b << 16)) >> (32 - log2n);
            if (b > a) {
                int reU = re[a];
                int imU = im[a];
                re[a] = re[b];
                im[a] = im[b];
                re[b] = reU;
                im[b] = imU;
            }
        }
        return (re, im);
    }
}
