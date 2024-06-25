// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9/access/Ownable.sol";
import "@openzeppelin/contracts@4.9/utils/math/SafeMath.sol";

contract DegenToken is ERC20, Ownable {
    using SafeMath for uint256;

    enum GachaItem {none, Zhongli, HuTao, Nahida}

    mapping(address => uint256) public burnedTokens;
    mapping(address => GachaItem[]) public inventory;

    event GachaResult(address indexed user, GachaItem item);
    event InventoryUpdated(address indexed user, GachaItem[] items);

    constructor() ERC20("Degen", "DGN") {
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        burnedTokens[msg.sender] = burnedTokens[msg.sender].add(amount);
    }

    function gacha() public payable {
        require(balanceOf(msg.sender) >= 100, "Insufficient balance to play gacha");
        require(burnedTokens[msg.sender] >= 1, "You must have burned tokens to play gacha");

        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender))) % 100;

        GachaItem item;

        if (randomNumber < 2) {
            item = GachaItem.Nahida;
        } else if (randomNumber < 35) {
            item = GachaItem.Zhongli;
        } else {
            item = GachaItem.HuTao;
        }

        inventory[msg.sender].push(item);
        _burn(msg.sender, 100); // Deduct 100 tokens for each gacha attempt

        emit GachaResult(msg.sender, item); // Emit an event with the gacha result
        emit InventoryUpdated(msg.sender, inventory[msg.sender]);
    }

    function getInventory() public view returns (string memory) {
        GachaItem[] memory items = inventory[msg.sender];
        uint256 zhongliCount;
        uint256 hutaoCount;
        uint256 nahidaCount;

        for (uint256 i = 0; i < items.length; i++) {
            if (items[i] == GachaItem.Zhongli) {
                zhongliCount++;
            } else if (items[i] == GachaItem.HuTao) {
                hutaoCount++;
            } else if (items[i] == GachaItem.Nahida) {
                nahidaCount++;
            }
        }

        return string(abi.encodePacked(
            "Zhongli: ", uint2str(zhongliCount),
            ", HuTao: ", uint2str(hutaoCount),
            ", Nahida: ", uint2str(nahidaCount)
        ));
    }

    function uint2str(uint _i) internal pure returns (string memory str) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length;
        j = _i;
        while (j != 0) {
            bstr[--k] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }
        str = string(bstr);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
}
