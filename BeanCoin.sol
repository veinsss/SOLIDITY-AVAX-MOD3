// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeanCoin is ERC20, Ownable {
    constructor(uint256 initialSupply)
        ERC20("BeanCoin", "BC")
        Ownable(msg.sender)
    {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Cannot mint to zero address");
        require(amount > 0, "Mint amount must be greater than 0");
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        require(amount > 0, "Burn amount must be greater than 0");
        require(
            balanceOf(msg.sender) >= amount,
            "Insufficient balance to burn"
        );
        _burn(msg.sender, amount);
    }

    function transferTokens(address recipient, uint256 amount) external {
        require(recipient != address(0), "Cannot transfer to zero address");
        require(amount > 0, "Transfer amount must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _transfer(_msgSender(), recipient, amount);
    }
}
