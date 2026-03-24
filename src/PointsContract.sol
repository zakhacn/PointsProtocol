// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

error NotOwner();
error AlreadyHasProfile();
error NotEnoughbal(uint count);

contract PointsContract{

    address public immutable owner;
    //A custom data type
    struct Profile{
        bool exists;//slot packing
        string username;
    }

    //event = log
    event TransferOccurred(address indexed from ,address indexed to,uint256 amount);
    event ApproveOccurred(address indexed owner,address indexed spender,uint256 amount);

    mapping (address=> Profile) profiles;
    mapping (address=>uint) balance;
    //Nested Mapping
    mapping (address=>mapping (address=>uint)) allowance;
    mapping (address=>uint) lockTime;

    modifier onlyOwner(){
       // require(msg.sender==owner,"Only the owner can do this!");
	if(msg.sender != owner) revert NotOwner();
        _;
    }

    constructor(){
        owner=msg.sender;
    }
    //lesson2-1 add a profile
    function setProfile(string calldata  _name) external{
        if(profiles[msg.sender].exists!=false) revert AlreadyHasProfile();
        profiles[msg.sender]=Profile({exists:true,username:_name});
    }

    function getProfile() external view returns (string memory,bool){
	Profile storage user = profiles[msg.sender];//use msg.sender only once 
        return (user.username,user.exists);
    }
    
    function increment() public {
        balance[msg.sender]+=500;
        lockTime[msg.sender]=block.timestamp+ 30 seconds;
    }
    //lesson2-2 used block.timestamp 
    function decrement() public {
	uint bal=balance[msg.sender];	
        if(bal<500) revert NotEnoughbal(bal);
        require(block.timestamp>=lockTime[msg.sender],"You have to wait 30 seconds");
	unchecked{
    	    balance[msg.sender]-=500;
	}
    }
    //lesson2-3 turned the contract into a "Bank" by accepting real Ether via payable and msg.value
    function buyPoints() public payable {
        require(msg.value>=7 gwei,"Not enough ETH sent");
        balance[msg.sender]+=50000;
    }
    //balance shows on the top of the Deployed Contracts Tab
    function getcontractbalance() public onlyOwner view returns(uint256) {
        return address(this).balance;
    }
    //lesson2-4 .call() , .transfer() and .send()
    function Withdraw() public onlyOwner{

        //bool success=payable(msg.sender).send(address(this).balance);
        //payable(msg.sender).transfer(address(this).balance);
        (bool success,)=payable(msg.sender).call{value:address(this).balance }("");

        require(success,"Transfer Failed");
    }
    //lesson2-5 ERC20 standard
    function approve(address spender,uint256 amount) public {
        allowance[msg.sender][spender]=amount;
    }
    //this function is not safe
    function approvebug(address boss,address spender, uint256 amount) public {
        allowance[boss][spender]=amount;
    }

    function transfer(address recipition, uint256 amount) external{
       // require(balance[msg.sender]>=amount,"Not enough balance");
	uint256 bal=balance[msg.sender];
	if(bal<amount) revert NotEnoughbal(bal);
	unchecked{
        	balance[msg.sender]-=amount;
        	balance[recipition]+=amount;
	}
        emit TransferOccurred(msg.sender,recipition,amount);
    }
    //use allowance
    function transferFrom(address from,address to,uint256 amount) public {
        require(msg.sender!=to,"can not transfer to youself");
        require(allowance[from][msg.sender]>=amount,"Not enough allowance");
        if(balance[from]<amount) revert NotEnoughbal(balance[from]);
        allowance[from][msg.sender]-=amount;
        balance[from]-=amount;
        balance[to]+=amount;
        emit TransferOccurred(from, to, amount);
    }
    
    function getBalance(address account) public view returns(uint256){
        return balance[account];
    }

    function getAllowance(address from, address to) public view returns(uint256){
        return allowance[from][to];
    }

}
