// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/access/Ownable.sol";

/**
 * @title Web3EventBadges
 * @dev Users can check in to a Web3 event and receive an NFT badge automatically.
 */
contract Web3EventBadges is ERC721URIStorage, Ownable {
    uint256 public participantCount;
    mapping(address => uint256) public attendance;
    string public baseURI;

    event CheckedIn(address indexed attendee, uint256 indexed tokenId, uint256 timestamp);

    constructor(string memory _baseURI) ERC721("Web3 Event Badge", "WEB") {
        baseURI = _baseURI;
    }

    function setBaseURI(string calldata _uri) external onlyOwner {
        baseURI = _uri;
    }

    function checkIn() external {
        require(attendance[msg.sender] == 0, "Already checked in");
        participantCount += 1;
        uint256 tokenId = participantCount;
        attendance[msg.sender] = block.timestamp;

        _safeMint(msg.sender, tokenId);

        string memory uri = string(abi.encodePacked(baseURI, uint2str(tokenId), ".json"));
        _setTokenURI(tokenId, uri);

        emit CheckedIn(msg.sender, tokenId, block.timestamp);
    }

    function hasAttended(address user) external view returns (bool) {
        return attendance[user] != 0;
    }

    function uint2str(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) return "0";
        uint256 j = _i;
        uint256 length;
        while (j != 0) { length++; j /= 10; }
        bytes memory bstr = new bytes(length);
        j = _i;
        while (j != 0) { bstr[--length] = bytes1(uint8(48 + j % 10)); j /= 10; }
        str = string(bstr);
    }
}
