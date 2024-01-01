// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Script.sol";

interface WRAPPER {
    function subz(int256, int256, int256, int256) external returns (int256, int256);
    function addz(int256, int256, int256, int256) external returns (int256, int256);
    function mulz(int256, int256, int256, int256) external returns (int256, int256);
    function divz(int256, int256, int256, int256) external returns (int256, int256);
    function calcR(int256, int256) external returns (uint256);

    function toPolar(int256, int256) external returns (int256, int256);
    function fromPolar(int256, int256) external returns (int256, int256);

    //   function p_atan2(int256, int256) external returns (int256);

    //   function atan1to1(int256) external returns (int256);

    function ln(int256, int256) external returns (int256, int256);

    function sqrt(int256, int256) external returns (int256, int256);

    function expZ(int256, int256) external returns (int256, int256);

    function pow(int256, int256, int256) external returns (int256, int256);
}

contract Deploy is Script {
    function run() public returns (WRAPPER complex) {
        complex = WRAPPER(HuffDeployer.deploy("ComplexHuff/WRAPPER"));
    }
}
