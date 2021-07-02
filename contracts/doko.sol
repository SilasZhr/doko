// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;




import './NonfungiblePositionManager.sol';

/// @title NFT positions
/// @notice Wraps Uniswap V3 positions in the ERC721 non-fungible token interface
contract doko is 
 NonfungiblePositionManager
{
    NonfungiblePositionManager private manager;


    constructor( address payable NonfungiblePositionManager_addr,
        address _factory,
        address _WETH9,
        address _tokenDescriptor_  ) NonfungiblePositionManager( _factory, _WETH9, _tokenDescriptor_) public{ 
        manager = NonfungiblePositionManager(NonfungiblePositionManager_addr);
    }

    function addLiqudity(MintParams memory params)
        external
        payable
        returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        )
    {   
    
        (tokenId, liquidity, amount0, amount1) =  manager.mint(params);
    }
}