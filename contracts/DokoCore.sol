pragma solidity ^0.7.6;
pragma abicoder v2;

import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";

contract DokoCore {
    INonfungiblePositionManager private manager;
    mapping(uint256 => positionDetail) public tokenPosition;

    struct positionDetail {
        address token0;
        address token1;
        address owner;
        uint128 liquidity;
    }

    constructor(
    ) {
        manager = INonfungiblePositionManager(
            0x5FC8d32690cc91D4c39d9d3abcBD16989F875707
        );
    }

    function deposite(uint256 tokenId, positionDetail calldata params)
        external
        returns (bool sucess)
    {
        manager.safeTransferFrom(msg.sender, address(this), tokenId);
        tokenPosition[tokenId] = positionDetail({
            token0: params.token0,
            token1: params.token1,
            owner: params.owner,
            liquidity: params.liquidity
        });
        sucess = true;
    }

    function removeLiquidity(uint256 tokenId)
        external
        payable
        returns (uint256 amount0, uint256 amount1)
    {
        (amount0, amount1) = manager.decreaseLiquidity(
            INonfungiblePositionManager.DecreaseLiquidityParams({
                tokenId: tokenId,
                liquidity: tokenPosition[tokenId].liquidity,
                amount0Min: 0,
                amount1Min: 0,
                deadline: 1725230979
            })
        );
        (amount0, amount1) = manager.collect(
            INonfungiblePositionManager.CollectParams({
                tokenId: tokenId,
                recipient: tokenPosition[tokenId].owner,
                amount0Max: uint128(amount0),
                amount1Max: uint128(amount1)
            })
        );
        tokenPosition[tokenId].liquidity = 0;
    }

    function withdraw(uint256 tokenId) public returns (bool sucess) {
        manager.safeTransferFrom(
            address(this),
            tokenPosition[tokenId].owner,
            tokenId
        );
        sucess = true;
    }
}
