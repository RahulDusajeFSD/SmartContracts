// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 < 0.9.0;

// import ownable contract from openzepplin.
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleToken is Ownable { 

    // NOT defining owner here as it is inherited from Ownable contract.
   // address owner; 


    // mapping of accounts' addresses with balances
    mapping(address => uint256) balances;

    // mapping of account's addresses to check account if denylisted/not - that's why boolen.
    mapping(address => bool) denylisted;

    constructor(uint256 balance) Ownable(msg.sender) {
        // not initializing the owner variable with msg.sender as it will be taken 
        // care by ownable contract as it has ownable contructor.


        //owner = msg.sender; // initialising value of owner with contract's address

        // initialising balance for sender with value at deployment of contract.
        balances[msg.sender] = balance;
    }

    // adhoc function to kno balance of an account. Just for debugging purpose.
    function getBalance(address account) public view returns (uint){
        return balances[account];
    }

    modifier not_denylisted() {
        //checking if the sender is not denylisted - if true proceed otherwise throw the error.
        require(denylisted[msg.sender] == false, "Oops, Sender is denylisted.");

        //placeholder for other functions to call.
        _;
    }

    modifier at_least(uint min_balance) {
        // checking if sender has minimum balance for the transaction.
        require(balances[msg.sender] >= min_balance, "Sorry not enough funds.");

        //placeholder for other functions to call.
        _;
    }

 function denylist(address account) public onlyOwner{
    require(denylisted[account] == false, "Account is already denylisted.");
        denylisted[account] = true;
    }

    function transfer(address recipient, uint token) public not_denylisted at_least(50) {


       balances[msg.sender] = balances[msg.sender] - token;
       balances[recipient] = balances[recipient] + token;

    }
    }


