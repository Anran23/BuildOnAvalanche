# DegenToken Smart Contract

DegenToken is an ERC20 token smart contract written in Solidity. It includes functionalities for token minting, burning, and a gacha game feature where users can obtain different items.

## Features

- **Token Details**
  - Name: Degen
  - Symbol: DGN
  - Total Supply: Minted by owner

- **Token Operations**
  - `mint`: Allows the contract owner to mint new tokens.
  - `burn`: Allows users to burn tokens, with burned amount tracked per user.

- **Gacha Game**
  - Users can play a gacha game to randomly obtain items: Zhongli, HuTao, or Nahida.
  - Requirements for gacha:
    - User must have at least 100 tokens in their balance.
    - User must have previously burned tokens.
  - Each gacha attempt costs 100 tokens.

- **Inventory**
  - Keeps track of each user's acquired items from the gacha game.
  - Provides a method `getInventory()` to view a user's inventory counts for each item type.

## Dependencies

- OpenZeppelin Contracts v4.9:
  - ERC20.sol
  - Ownable.sol
  - SafeMath.sol

## Installation and Usage

To deploy and use the contract:

1. **Install Dependencies**: Ensure OpenZeppelin Contracts v4.9 is installed.

2. **Deploy Contract**: Deploy `DegenToken.sol` on a compatible Ethereum network.

3. **Interact with Contract**:
   - Mint tokens to distribute.
   - Burn tokens to participate in the gacha game.
   - Play the gacha game using `gacha()` method.
   - Check inventory using `getInventory()` method.

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9/access/Ownable.sol";
import "@openzeppelin/contracts@4.9/utils/math/SafeMath.sol";

contract DegenToken is ERC20, Ownable {
    // Contract code here...
}

## License

This project is licensed under the MIT License. See the LICENSE file for details.

