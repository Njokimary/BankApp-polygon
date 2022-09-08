// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BankApp {
    address public manager;

    event Register(address creator,uint256 accountid,uint256 timestamp);
    event Deposit(address sender,uint256 amount,uint256 timestamp);
    event Transfer(address sender,address receiver,uint256 amount,uint256 timestamp);
    event Withdraw(address user,uint256 amount,uint256 timestamp);



    struct Account {
        uint256 id;
        string name;
        string krapin;
        uint256 balance;
        bool status;
    }
    mapping(address => Account) accounts;

    modifier isloggedin(address _user){
        Account memory account = accounts[_user];
        if(!account.status){
            revert("User not logged in");
        }
        _;

    }

    constructor(string memory _name) {
        string memory name;
        manager = msg.sender;
        name = _name;
    }

    function register(
        address user,
        uint256 id,
        string memory name,
        string memory krapin,
        uint256 balance
    ) public returns (bool) {
        require(msg.sender == manager, "send not manager");

        Account memory account = accounts[user];
        //check if the account is created
        if (account.id != 0) {
            revert("Account already exist");
        }
        account.id = id;
        account.name = name;
        account.krapin = krapin;
        account.balance = balance;

        accounts[user] = account;
        //emit the event
        emit Register(msg.sender,id,block.timestamp);
        return true;

    }

    function login() public returns (bool) {
        address _user = msg.sender;
        Account storage account = accounts[_user];

        //check if the user account exist.if not,revert with an error
        if (account.id == 0) {
            revert("Account does not exist");
        }

        if (account.status) {
            return true;
        }
        account.status = true;

        //accounts[_user]=account;
        //ensures the user is logged in and the functions accepts only a specific amount
        return account.status;
    }
    function deposit (uint256 amount)  public isloggedin(msg.sender) {
        Account memory account = accounts[msg.sender];
        account.balance += amount;

        accounts[msg.sender] = account;

        emit Deposit(msg.sender,amount,block.timestamp);

    }

    function withdraw (uint256 amount)  public isloggedin(msg.sender) {
        Account memory account = accounts[msg.sender];
        account.balance -= amount;

        accounts[msg.sender] = account;

        emit Withdraw(msg.sender,amount,block.timestamp);

    

    }
    function balanceof(address _user)
    public 
    view
    isloggedin(msg.sender)
    returns (uint256)
    {
        Account memory account = accounts[_user];
        return account.balance;

    }
    function transfer (address _to, uint256 amount)
    public 
    isloggedin(msg.sender)
    {
        Account storage account0 = accounts[msg.sender];
        Account storage account1 =accounts [_to];
        require (account0.balance >= amount,"Insufficient fund");
        require (account1.id !=0, "Acount does not exist");

        account0.balance -=amount;
        account1.balance +=amount;

        emit Transfer(msg.sender,_to,amount,block.timestamp);

    }


}
