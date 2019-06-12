pragma solidity ^0.5.8;

contract LearningLogs {
    // type define
    enum Judge {AC, RE, CE}
    struct Data {
        Judge judge;
        bytes32 code_hash;
    }

    // state variables
    mapping(address=>mapping(bytes32=>Data)) datas;
    mapping(address=>bytes32[]) submissionOf;
    mapping(bytes32=>address[]) answererOf;

    // functions (no constructor)
    function getData(address publisher, string memory url) public view returns(Judge,bytes32) {
        Data memory d = datas[publisher][url2id(url)];
        return (d.judge, d.code_hash);
    }

    function getSolvedList(address publisher) public view returns(bytes32[] memory) {
        return submissionOf[publisher];
    }

    function getAnswererList(string memory url) public view returns(address[] memory) {
        return answererOf[url2id(url)];
    }

    function setData(Judge _j, bytes32 _ch, string memory url) public returns(bool) {
        bytes32 problemId = url2id(url);
        datas[msg.sender][problemId] = Data({
            judge: _j,
            code_hash: _ch
        });
        submissionOf[msg.sender].push(problemId);
        answererOf[problemId].push(msg.sender);
        return true;
    }

    function url2id(string memory url) internal pure returns(bytes32) {
        return keccak256(abi.encode(url));
    }
    function makeDataId(Data memory d) internal pure returns(bytes32) {
        return keccak256(abi.encodePacked(d.judge, d.code_hash));
    }
}
