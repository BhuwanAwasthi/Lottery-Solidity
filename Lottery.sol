
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{

address public manager;
address payable[] public part;
//to transfer we use payable

constructor ()
{
    manager=msg.sender; //gives full access to manager
}//receive can be used only once to receive transaction
receive() external payable
{
    require(msg.value==2 ether);
    part.push(payable(msg.sender));
}

function getBalance() public view returns(uint)
{
    require(msg.sender==manager,"You are not a manager");
    return address(this).balance;
}
    function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, part.length)));
    }//this will generate a random uint number which may be out of the participants

function selectWinner() public returns(address){
require(msg.sender==manager,"You are not manager");
require(part.length>=3);
uint r=random();
address payable winner;
uint index=r%part.length;
winner=part[index];
winner.transfer(getBalance());
//function to reset the contract
part=new address payable[](0);
return winner;


}
}
