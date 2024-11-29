// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeanCoin is ERC20, Ownable {
    constructor() ERC20("BeanCoin", "BC") Ownable(msg.sender) {}

    event Purchase(address indexed buyer, string item, uint256 amount);

    uint256 public constant americano = 5;
    uint256 public constant latte = 10;
    uint256 public constant mocha = 15;
    uint256 public constant cappuccino = 20;

    function Toast(address to, uint256 amount) external onlyOwner {
        require(
            amount > 0,
            "You can't toast 0 beans"
        );
        _mint(to, amount);
    }

    function buyItem(string memory item) external {
        uint256 price;

        if (
            keccak256(abi.encodePacked(item)) ==
            keccak256(abi.encodePacked("americano"))
        ) {
            price = americano;
        } else if (
            keccak256(abi.encodePacked(item)) ==
            keccak256(abi.encodePacked("latte"))
        ) {
            price = latte;
        } else if (
            keccak256(abi.encodePacked(item)) ==
            keccak256(abi.encodePacked("mocha"))
        ) {
            price = mocha;
        } else if (
            keccak256(abi.encodePacked(item)) ==
            keccak256(abi.encodePacked("cappuccino"))
        ) {
            price = cappuccino;
        } else {
            revert("Item not available");
        }

        require(
            balanceOf(msg.sender) >= price,
            "Insufficient beans to brew this item"
        );

        _burn(msg.sender, price);
        emit Purchase(msg.sender, item, price);
    }
}
