pragma solidity ^0.5.8;

contract LearningHistory {
    enum Judge {Accept, RuntimeError, CompileError}
    struct Record {
        Judge judge;
        bytes32 code_hash;
    }

    mapping(bytes32=>address) ownerOfRecord;  // Refer by recordID

    function makeRecordId(Record memory r) internal pure returns(bytes32) {
        return keccak256(abi.encodePacked(r.judge, r.code_hash));
    }
}
