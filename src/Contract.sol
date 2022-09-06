// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Clicker is Ownable {
    mapping(IERC721 => mapping(uint256 => uint256)) public ownerClicks;
    mapping(IERC721 => mapping(uint256 => uint256)) public nonOwnerClicks;
    bool public active = true;

    modifier whenClickingIsActive() {
        require(active, "Clicking not active");
        _;
    }

    /**
     * @dev Get total number of clicks
     * @param _contract Address
     * @param _tokenId Token ID
     * @return total clicks
     */
    function getTotalClicks(IERC721 _contract, uint256 _tokenId)
        external
        view
        returns (uint256)
    {
        return
            ownerClicks[_contract][_tokenId] +
            nonOwnerClicks[_contract][_tokenId];
    }

    /**
     * @dev Store value in variable
     * @param _contract Contract
     * @param _tokenId Token
     */
    function click(IERC721 _contract, uint256 _tokenId)
        external
        whenClickingIsActive
    {
        if (msg.sender == owner()) {
            unchecked {
                ++ownerClicks[_contract][_tokenId];
            }
        } else {
            unchecked {
                ++nonOwnerClicks[_contract][_tokenId];
            }
        }
    }

    /// @notice Pauses or Unpauses clicking
    /// @dev Only accessible by owner
    function pause() external onlyOwner {
        active = !active;
    }
}
