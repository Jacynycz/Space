pragma solidity ^0.4.0;

contract SpaceContainer{

    enum SpaceState{
        INIT,     // contract created by source address
        CONFIRMED,     // contract sent to destination address
        LOCKED,   // destination adress locked the contract
        XTRACT // destination addess now can extract the ETH
    }
    address public _source;
    address public _dest;
    uint public _amount;
    uint public _frag;
    uint public _time;
    SpaceState _state;

    event SpaceStateChanged(address, SpaceState);

    modifier sourceOnly(){
        if (msg.sender != _source) return;
        _;
    }

    modifier destinationOnly(){
        if (msg.sender != _dest) return;
        _;
    }

    function SpaceContainer(
        address source,
        address dest,
        uint time,
        uint frag){
        _source = source;
        _dest = dest;
        _time = time;
        _frag = frag;
    }

    function setAmount() payable {
        _amount = msg.value;
    }

    function setTime(uint time){
        _time = time;
    }

    function setFrag(uint frag){
        _frag = frag;
    }

    function confirmSpaceContainer()
    sourceOnly()
    {
        _state = SpaceState.CONFIRMED;
        SpaceStateChanged(msg.sender,SpaceState.CONFIRMED);
    }

    function extractFunds(){

    }
}

contract Space {
    //Secure Payment Contracts in Ethereum
    address _creator;
    function Space(){
        _creator = msg.sender;
    }


    function newSpaceContainer() returns (SpaceContainer){
        SpaceContainer container = new SpaceContainer(_creator,_creator,0,0);
        return container;
    }
}
