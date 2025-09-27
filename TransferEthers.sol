// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract ReceiveEther {

// receive() for receiving plain eth transfer with no data. 
// fallback() for ether receiving with unknown data -- msg.data

receive() external payable{

}

fallback() external payable{

}


function getBalance() public view returns(uint256){
return address(this).balance; // returns balance of the contract.
}


}


contract SendEther {

    // 3 built-in methods to send ethers - transfer, send, call

    function sendViaTransfer(address payable _to) public payable {
        //Not Recommended anymore
        _to.transfer(msg.value);

    }

    function sendViaSend(address payable _to) public payable {
        // returns boolen
        // Not Recommended anymore

        bool sent = _to.send(msg.value);
        require(sent, "Failed to Send Ether");  // Failed To Send Ether -- only gets called if Sent is false.
        // remember, require revers the whole transaction with error message
    }

    function sendViaCall(address payable _to) public payable{

        // Recommended for use

        // Returns True for success False for Failure

        (bool sent, bytes memory data) = _to.call{value: msg.value, gas: 10000}("");
        require(sent, "Failed to Send Ethers");
    }

    
    // send, transfer have fixed 2300 gas which doule be insufficient for sending ethers
    //with call fn - we can set the customize gas 
}
