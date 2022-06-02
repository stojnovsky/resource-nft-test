// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract NFT is ERC721 {
  uint public nextTokenId;
  uint public availableTokens;
  address public admin;
  mapping(uint256 => string) private _meta;

  constructor() ERC721('GAS TANK NFT', 'AGTN') {
    admin = msg.sender;
  }
  
  function mint(address to, string memory nftType) external {
    require(msg.sender == admin, 'only admin');
    // require(nextTokenId < availableTokens);
    if (keccak256(abi.encodePacked((nftType))) == keccak256(abi.encodePacked(("10")))) {
      _meta[availableTokens++] = "10";
    } else if (keccak256(abi.encodePacked((nftType))) == keccak256(abi.encodePacked(("20")))) {
      _meta[availableTokens++] = "20";
    } else if (keccak256(abi.encodePacked((nftType))) == keccak256(abi.encodePacked(("30")))) {
      _meta[availableTokens++] = "30";
    } else if (keccak256(abi.encodePacked((nftType))) == keccak256(abi.encodePacked(("50")))) {
      _meta[availableTokens++] = "50";
    } else {
      require(false, "WRONG NFT TYPE");
    }
    _safeMint(to, nextTokenId);
    nextTokenId++;
  }

  function _baseURI() internal view override returns (string memory) {
    return 'https://raw.githubusercontent.com/stojnovsky/resource-nft-test/main/json/';
  }

  function tokenURI(uint256 availableTokens) public view virtual override returns (string memory) {
    require(_exists(availableTokens), "ERC721Metadata: URI query for nonexistent token");
    // return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    return string(abi.encodePacked(_baseURI(), _meta[availableTokens], ".json"));
  }
}