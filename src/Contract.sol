// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Clicker is Ownable {

    mapping (address=>mapping(uint256=>uint256)) public ownerClicks;
    mapping (address=>mapping(uint256=>uint256)) public nonOwnerClicks;

    /**
    * @dev Get total number of clicks
    * @return num total clicks
    */
    function getTotalClicks(address _contract, uint256 _tokenId) external view returns (uint256){
        return ownerClicks[_contract][_tokenId] + nonOwnerClicks[_contract][_tokenId];
    }


    /**
     * @dev Store value in variable
     * @param _contract Contract
     * @param _tokenId Token
     */
    function click(address _contract, uint256 _tokenId) external {
        if(msg.sender == owner()){
            unchecked{
                ++ownerClicks[_contract][_tokenId];
            }
        } else{
            unchecked{
                ++nonOwnerClicks[_contract][_tokenId];
            }
        }
    }
}
