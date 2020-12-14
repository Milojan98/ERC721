pragma solidity >=0.4.25 <0.7.0;

import "./MyTokenERC721.sol";

abstract contract MinterContract is MyTokenERC721{
    event UpdateWhitelist(address _account, bool _value);
    event aTokenWasClaimed(uint _tokenNumber, address _tokenClaimer);

    //mapping(address => bool) public whitelist;

    address public ERC721address;
    bytes32 public hashToSignToGetWhiteListed = "You need to sign this string";
    //bytes32 parametersEncoded = abi.encodeParameters(['bytes32'], [hashToSignToGetWhiteListed]);
    //byte32 signature = let sign(parametersEncoded,accounts[1]);

    constructor(address _ERC721address) public {
        whitelist[msg.sender] = true;
        ERC721address = _ERC721address;
    }

    function claimAToken(bytes memory _signature) public returns (bool)
    {

        MyTokenERC721 myERC721 = MyTokenERC721(ERC721address);

        // Finding next token id
        uint nextTokenToMint = myERC721.nextTokenId();

        // Creating a hash of the concatenation of the ERC721 address and the next token to mint
        bytes32 _hash = keccak256(abi.encode(ERC721address, nextTokenToMint));

        // Checking that the signer of the mint order is authorized
        require(signerIsWhitelisted(_hash, _signature), "Claim: signer not whitelisted or signature invalid");
            
        // Checking that the authorized minter is not the claimer
        address tokenMintedBy = extractAddress(_hash , _signature);
        require(tokenMintedBy != msg.sender, "Minter and sender must be different");

        myERC721.mint(msg.sender);
    }    

     function extractAddress(bytes32 _hash, bytes memory _signature) internal pure returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;
        // Check the signature length
        if (_signature.length != 65) {
            return address(0);
        }
        // Divide the signature in r, s and v variables
        // ecrecover takes the signature parameters, and the only way to get them
        // currently is to use assembly.
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            r := mload(add(_signature, 32))
            s := mload(add(_signature, 64))
            v := byte(0, mload(add(_signature, 96)))
        }
        // Version of signature should be 27 or 28, but 0 and 1 are also possible versions
        if (v < 27) {
            v += 27;
        }
        // If the version is correct return the signer address
        if (v != 27 && v != 28) {
            return address(0);
        } else {
            // solium-disable-next-line arg-overflow
            return ecrecover(keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash)
                ), v, r, s);
        }
    }

    function signerIsWhitelisted(bytes32 _hash, bytes memory _signature) internal view returns (bool) {
		bytes32 r;
		bytes32 s;
		uint8 v;
		// Check the signature length
		if (_signature.length != 65) {
			return false;
		}
		// Divide the signature in r, s and v variables
		// ecrecover takes the signature parameters, and the only way to get them
		// currently is to use assembly.
		// solium-disable-next-line security/no-inline-assembly
		assembly {
			r := mload(add(_signature, 32))
			s := mload(add(_signature, 64))
			v := byte(0, mload(add(_signature, 96)))
		}
		// Version of signature should be 27 or 28, but 0 and 1 are also possible versions
		if (v < 27) {
			v += 27;
		}
		// If the version is correct return the signer address
		if (v != 27 && v != 28) {
			return false;
		} else {
			// solium-disable-next-line arg-overflow
			return whitelist[ecrecover(keccak256(
				abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash)
				), v, r, s)];
        }
	}

	function updateWhitelist(address _account, bool _value) onlyWhitelisted public returns (bool) {
        whitelist[_account] = _value;
        emit UpdateWhitelist(_account, _value);
        return true;
    }

}