

###

The below Smart Contracts - Greeter defines two statev variables, a construct to initialize their values.
The user inputs the value of greeting, the condition is only the owner of the contract(msg.sender) which is recorded through constructor at the time of contract deployment, should be able to set
greetings. If another account tries to set it, it will fail as we have require condition.

####

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;
contract Greeter {
    // declaring state variables
    string private greeting;  
    address private creator;  
    constructor(string memory _greeting) {
        
        //initializing the state variables using the constructor.
        greeting = _greeting;
        creator = msg.sender; // initialising the creator with deployer address.
    }
    function setGreeting(string calldata changeGreeting) public  {
        require(
            creator == msg.sender, 
            // to check if the same account which deployed
            // is eligible to change greeting
            "Sorry can't modify the state since caller isn't creator of contract."
        );        
        greeting = changeGreeting; // changing greeting upon successful validation
    }
    function getAll() public view returns (string memory, address){
         return (greeting, creator);  // returning the state variables.
    }
}
