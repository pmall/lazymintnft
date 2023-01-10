// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/LazyMintNFT.sol";

contract LazyMintNFTTest is Test {
    LazyMintNFT lazyMintNFT;

    function setUp() public {
        lazyMintNFT = new LazyMintNFT();
    }

    function testOwnerCanSafeMint() public {
        lazyMintNFT.safeMint(address(1), "http://example.com/1.json");
        lazyMintNFT.safeMint(address(2), "http://example.com/2.json");
        lazyMintNFT.safeMint(address(1), "http://example.com/3.json");

        uint256 total = lazyMintNFT.totalSupply();
        uint256 index1 = lazyMintNFT.tokenByIndex(0);
        uint256 index2 = lazyMintNFT.tokenByIndex(1);
        uint256 index3 = lazyMintNFT.tokenByIndex(2);
        uint256 ownerIndex1 = lazyMintNFT.tokenOfOwnerByIndex(address(1), 0);
        uint256 ownerIndex2 = lazyMintNFT.tokenOfOwnerByIndex(address(1), 1);
        uint256 ownerIndex3 = lazyMintNFT.tokenOfOwnerByIndex(address(2), 0);
        address owner1 = lazyMintNFT.ownerOf(0);
        address owner2 = lazyMintNFT.ownerOf(1);
        address owner3 = lazyMintNFT.ownerOf(2);
        uint256 balance1 = lazyMintNFT.balanceOf(address(1));
        uint256 balance2 = lazyMintNFT.balanceOf(address(2));
        string memory tokenURI1 = lazyMintNFT.tokenURI(0);
        string memory tokenURI2 = lazyMintNFT.tokenURI(1);
        string memory tokenURI3 = lazyMintNFT.tokenURI(2);

        assertEq(total, 3);
        assertEq(index1, 0);
        assertEq(index2, 1);
        assertEq(index3, 2);
        assertEq(ownerIndex1, 0);
        assertEq(ownerIndex2, 2);
        assertEq(ownerIndex3, 1);
        assertEq(owner1, address(1));
        assertEq(owner2, address(2));
        assertEq(owner3, address(1));
        assertEq(balance1, 2);
        assertEq(balance2, 1);
        assertEq(tokenURI1, "http://example.com/1.json");
        assertEq(tokenURI2, "http://example.com/2.json");
        assertEq(tokenURI3, "http://example.com/3.json");
    }

    function testFailOwnerCanSafeMintWhenPaused() public {
        lazyMintNFT.pause();

        lazyMintNFT.safeMint(address(1), "http://example.com/1.json");
    }

    function testOwnerCanSafeMintWhenPausedThenUnpaused() public {
        lazyMintNFT.pause();
        lazyMintNFT.unpause();

        lazyMintNFT.safeMint(address(1), "http://example.com/1.json");
    }
}
