// SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";

pragma solidity ^0.8.17;
pragma abicoder v2;

contract SwapUni {
    ISwapRouter public immutable swapRouter;
    address TOKEN_IN;
    address TOKEN_OUT;
    uint24 FEE;

    constructor(ISwapRouter _swapRouter) {
        swapRouter = _swapRouter;
    }

    function setData(
        address _tokenIn,
        address _tokenOut,
        uint24 _fee
    ) public {
        TOKEN_IN = _tokenIn;
        TOKEN_OUT = _tokenOut;
        FEE = _fee;
    }

    function swap(uint256 _amountIn) public returns (uint256 _amountOut) {
        console.log("Transferring to...");
        TransferHelper.safeTransferFrom(
            TOKEN_IN,
            msg.sender,
            address(this),
            _amountIn
        );
        console.log("Approving token...");
        TransferHelper.safeApprove(TOKEN_IN, address(swapRouter), _amountIn);
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: TOKEN_IN,
                tokenOut: TOKEN_OUT,
                fee: FEE,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: _amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });
        _amountOut = swapRouter.exactInputSingle(params);
    }
}

//address uniswapv3Router = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
