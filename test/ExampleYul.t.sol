// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./lib/YulDeployerAbstract.sol";
import "forge-std/console.sol";  // For console log

// Written by Taehwa
// Not sure what's the cause but 'owner' and  'caller' have different address sometimes thus calledByOwner() never works
// I solved by inheriting or implement deployContract() inside each test contract
interface Example {
    // function onlyOwner() external;
    function onlyOwner() external returns(address);
}

contract ExampleTest is YulDeployerAbstract {
    Example exampleContract;

    function setUp() public {
        exampleContract = Example(deployContract("Example"));
    }

    function testOnlyOwner() public {
        address ownerAddr = exampleContract.onlyOwner();

        console.log('owner!! >>>', ownerAddr);
        console.log('msg.sender ***', msg.sender);
        console.log('tx.origin &&&', tx.origin);
    }
}
