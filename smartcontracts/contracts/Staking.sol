// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract Staking {
    address public owner;

    struct Position {
        uint positionId;
        address walletAddress;
        uint createdDate;
        uint unlockDate;
        uint percentInterest;
        uint weiStaked;
        uint weiInterest;
        bool open;        
    }

    Position position;

    uint public currentPositionId;
    mapping (uint => Position) public positions;
    mapping (address => uint[]) public positionsIdsByAddress;
    mapping (uint => uint) public tiers;
    uint[] public locksPeriods;

    constructor () payable {
        owner = msg.sender;
        currentPositionId =0;

        tiers[0] = 700;
        tiers[30] =800;
        tiers[60] =900;
        tiers[90] =1200;

        locksPeriods.push(0);
        locksPeriods.push(30);
        locksPeriods.push(60);
        locksPeriods.push(90);
    }

    function StakeEther(uint numDays)
        external
        payable{
        require( tiers[numDays]>0, "Mapping not found");

        positions[currentPositionId] = Position(
            currentPositionId,
            msg.sender,
            block.timestamp,
            block.timestamp + (numDays * 1 days),
            tiers[numDays],
            msg.value,
            calculateInterest( tiers[numDays], msg.value),
            true
        );

        positionsIdsByAddress[msg.sender].push(currentPositionId);
        currentPositionId += 1;
    }

    function calculateInterest(uint basisPoint, uint weiAmount) 
        private 
        pure
        returns (uint)
    {
        return basisPoint * weiAmount /1000 ;
    }

    function getLockPeriods() 
        external
        view
        returns (uint[] memory)
    {
        return locksPeriods;
    }

    function getInterestRate(uint numDays)
        external
        view
        returns (uint)
    {
        return tiers[numDays];
    }

    function getPositionById(uint positionId)
        external
        view
        returns (Position memory)
    {
        return positions[positionId];
    }

    function getPositionIdsForAddress(address walletAddress)
        external
        view
        returns (uint[] memory)
    {
        return positionsIdsByAddress[walletAddress];
    }

    function closePosition(uint positionId) 
        external
    {
        require(positions[positionId].walletAddress == msg.sender , "Only position creator can close position");
        require(positions[positionId].open == true, "Position already closed");

        positions[positionId].open=false;

        uint amount = positions[positionId].weiStaked + positions[positionId].weiInterest;
        // payable(msg.sender).call{value: amount}("");
        payable(msg.sender).transfer(amount);        
    }



}
