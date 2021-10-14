
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {
    uint32 public timestamp;
    string[] public members;

    constructor() public 
    {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        timestamp = now;
    }

    function getInLine(string newMember) external {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        members.push(newMember);
    }
    function exitQueue() external 
    {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        if (members.length == 0)
            return;

        for (uint8 i = 0; i < members.length - 1; i++)
            members[i] = members[i + 1];
        
        members.pop();
    }
}
