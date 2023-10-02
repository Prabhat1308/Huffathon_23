// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Script.sol";

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

    function calcR(
        int256,
        int256,
        int256,
        int256
    ) external returns (int256, int256);

    function toPolar(int256, int256) external returns (int256, int256);

    function fromPolar(int256, int256) external returns (int256, int256);

    function p_atan2(int256, int256) external returns (int256);

    function atan1to1(int256) external returns (int256);

    function ln(int256, int256) external returns (int256);

    function sqrt(int256, int256) external returns (int256);

    function expZ(int256, int256) external returns (int256, int256);

    function pow(int256, int256, int256) external returns (int256, int256);
}

contract Deploy is Script {
    function run() public returns (Complex complex) {
        complex = Complex(HuffDeployer.deploy("ComplexMath"));
    }
}
