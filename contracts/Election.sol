//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.8.0;

contract Election {

    // Create the candidates structure

    struct Candidate {
        uint id;
        string name;
        uint CountOfVotes;
    }

    // Through the use of mapping we load and fetch the number of our voters
    mapping(address => bool) public voters;

    // As mentioned above, the same process is being done
    // for our future politcians
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public CountOfCandidates;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor() public {
        NewCandidate("Candidate 1");
        NewCandidate("Candidate 2");
        NewCandidate("Candidate 3");
        NewCandidate("Candidate 4");
        NewCandidate("Candidate 5");
    }

    function NewCandidate (string memory _name) private {
        CountOfCandidates ++;
        candidates[CountOfCandidates] = Candidate(CountOfCandidates, _name, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= CountOfCandidates);

        // check if a voter has already voted
        voters[msg.sender] = true;

        // Update the total number of votes
        candidates[_candidateId].CountOfVotes ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
