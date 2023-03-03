// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./lib/YulDeployer.sol";
import "forge-std/console.sol";  // For console log

interface Example {
    function onlyOwner() external returns(address);
}

contract ExampleTest is Test {
    YulDeployer yulDeployer = new YulDeployer();

    Example exampleContract;

    function setUp() public {
        exampleContract = Example(yulDeployer.deployContract("Example"));
    }

    function testOnlyOwner() public {
        address ownerAddr = exampleContract.onlyOwner();

        console.log('owner!! >>', ownerAddr);
        console.log('msg.sender ***', msg.sender);
        console.log('tx.origin &&&', tx.origin);
    }
}
