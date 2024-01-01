// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./trig.sol";

contract FFT {
    // int[8] public real_part = [int(0) * 1e18,1 * 1e18,3 * 1e18,4 * 1e18,4 * 1e18,3 * 1e18,1 * 1e18,0];
    // int[8] public complex_part = [int(0) * 1e18,1 * 1e18,3 * 1e18,4 * 1e18,4 * 1e18,3 * 1e18,1 * 1e18,0];
    // int[4] public real_part = [int(1) * 1e18, -1 * 1e18, 0 * 1e18, 0 * 1e18];
    // int[4] public complex_part = [int(0) * 1e18, 0 * 1e18, 1 * 1e18, -1 * 1e18];

    uint256 PI = 3141592653589793238; // PI * 1e18

    struct complex {
        int256 real;
        int256 img;
    }

    function Log2(uint256 len) public pure returns (uint256) {
        uint256 log_val = 0;
        while (len != 1) {
            len = len / 2;
            log_val++;
        }
        return log_val;
    }

    function fft(int256[] memory real_part, int256[] memory complex_part)
        public
        view
        returns (int256[] memory, int256[] memory)
    {
        uint256 N = real_part.length;
        uint256 k = N;
        uint256 n;
        uint256 thetaT = (PI / N);
        complex memory phiT = complex(Trigonometry.cos(thetaT), -Trigonometry.sin(thetaT));

        complex memory T;
        while (k > 1) {
            n = k;
            k >>= 1;
            int256 phiT_real__temp = phiT.real;
            phiT.real = (((phiT.real * phiT.real) / 1e18) - ((phiT.img * phiT.img) / 1e18));
            phiT.img = (2 * phiT.img * phiT_real__temp) / 1e18;
            // if (k == 2) require(phiT.real / 1e12 == 0);
            T.real = 1 * 1e18;
            T.img = 0 * 1e18;
            for (uint256 l = 0; l < k; l++) {
                for (uint256 a = l; a < N; a += n) {
                    uint256 b = a + k;

                    complex memory t;
                    t.real = real_part[a] - real_part[b];
                    t.img = complex_part[a] - complex_part[b];
                    real_part[a] = real_part[a] + real_part[b];
                    complex_part[a] = complex_part[a] + complex_part[b];
                    real_part[b] = (((T.real * t.real) / 1e18) - ((T.img * t.img) / 1e18));
                    complex_part[b] = (((T.real * t.img) / 1e18) + ((T.img * t.real) / 1e18));
                }
                int256 T_real_temp = T.real;
                T.real = (((T.real * phiT.real) / 1e18) - ((T.img * phiT.img) / 1e18));
                T.img = (((T_real_temp * phiT.img) / 1e18) + ((T.img * phiT.real) / 1e18));
            }
        }

        uint256 m = Log2(N);
        for (uint256 a = 0; a < N; a++) {
            uint256 b = a;
            b = (((b & 0xaaaaaaaa) >> 1) | ((b & 0x55555555) << 1));
            b = (((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2));
            b = (((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4));
            b = (((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8));
            b = ((b >> 16) | (b << 16)) >> (32 - m);
            if (b > a) {
                int256 t_real = real_part[a];
                int256 t_img = complex_part[a];
                real_part[a] = real_part[b];
                complex_part[a] = complex_part[b];
                real_part[b] = t_real;
                complex_part[b] = t_img;
            }
        }
        return (real_part, complex_part);
    }
}
