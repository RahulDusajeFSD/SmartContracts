

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";


interface IToken {


    function transfer(address _recipient, uint _amount) external returns (bool);

    function totalSupply()  external view returns (uint);

    function balanceOf(address _owner)  external view returns (uint);
}

// inheriting IToken interface and Ownable contract
contract StandardToken is IToken, Ownable {

    mapping(address => uint) _balances;

    uint _totalSupply;

    string _name;

    string _symbol;

    // initialise values during deployment.
    constructor (uint totalSupply, string memory name, string memory symbol) Ownable(msg.sender) {

        _totalSupply = totalSupply;
        _name = name;
        _symbol = symbol;
        _balances[msg.sender] = totalSupply;
    }

    // only owner (Account deploying the contract) will be able to call mint.
    // Taken care by onlyOwner function.
    function mint(address _owner, uint amount) public onlyOwner(){

        // adding mint amount to total supply.
        _totalSupply = _totalSupply + amount;

        // updating current balance of owner with mint amount.
        _balances[_owner] = _balances[_owner] +  amount;
    }

    function transfer(address _recipient, uint _amount) public returns (bool) {

       _balances[msg.sender] = _balances[msg.sender] - _amount;
       _balances[_recipient] = _balances[_recipient] + _amount;

       return true;

    }

    function balanceOf(address _account) public view returns (uint){
        return _balances[_account];
    }

    function totalSupply() public view returns (uint){

        return _totalSupply;
    }

    

}
