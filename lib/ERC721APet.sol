// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../ERC721A/contracts/extensions/ERC721ABurnable.sol";
import "../ERC721A/contracts/extensions/ERC721AQueryable.sol";
import "../ERC721A/contracts/extensions/ERC4907A.sol";
import "../openzeppelin/contracts/access/Ownable.sol";
import "../openzeppelin/contracts/token/common/ERC2981.sol";

abstract contract ERC721APet is
    ERC721ABurnable,
    ERC721AQueryable,
    ERC4907A,
    ERC2981,
    Ownable
{
    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        virtual
        override(ERC4907A, ERC2981, IERC721A, ERC721A)
        returns (bool)
    {
        // The interface IDs are constants representing the first 4 bytes
        // of the XOR of all function selectors in the interface.
        // See: [ERC165](https://eips.ethereum.org/EIPS/eip-165)
        // (e.g. `bytes4(i.functionA.selector ^ i.functionB.selector ^ ...)`)
        return
            interfaceId == 0x01ffc9a7 || // ERC165 interface ID for ERC165.
            interfaceId == 0x80ac58cd || // ERC165 interface ID for ERC721.
            interfaceId == 0x5b5e139f || // ERC165 interface ID for ERC721Metadata.
            interfaceId == 0xad092b5c || // The interface ID for ERC4907 is `0xad092b5c`,
            interfaceId == type(IERC2981).interfaceId || //0x2a55205a
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {ERC2981-_setDefaultRoyalty}.
     * 10=1%
     */
    function setDefaultRoyalty(
        address receiver,
        uint96 feeNumerator
    ) public onlyOwner {
        _setDefaultRoyalty(receiver, feeNumerator * 10);
    }

    /**
     * @dev See {ERC2981-_deleteDefaultRoyalty}.
     */
    function deleteDefaultRoyalty() external onlyOwner {
        _deleteDefaultRoyalty();
    }

    /**
     * @dev See {ERC2981-_setTokenRoyalty}.
     */
    function setTokenRoyalty(
        uint256 tokenId,
        address receiver,
        uint96 feeNumerator
    ) external onlyOwner {
        _setTokenRoyalty(tokenId, receiver, feeNumerator);
    }

    /**
     * @dev See {ERC2981-_resetTokenRoyalty}.
     */
    function resetTokenRoyalty(uint256 tokenId) external onlyOwner {
        _resetTokenRoyalty(tokenId);
    }
}
