# ERC721

:heavy_check_mark: Create a truffle project and configure it on Infura 

:heavy_check_mark: Create a mintable ERC721 smart contract 

:heavy_check_mark: Create a minter contract that is allowed to mint ERC721 tokens 

:heavy_check_mark: Integrate function signerIsWhitelisted() from bouncerProxy in your contract with all associated variables 

:heavy_check_mark: Get whitelisted on contract 0x53bb77F35df71f463D1051061B105Aafb9A87ea1 on Rinkeby
![image 1](https://github.com/Milojan98/ERC721/blob/main/images/2020-12-16%20(2).png)
![image 2](https://github.com/Milojan98/ERC721/blob/main/images/2020-12-16%20(1).png)

:x: Claim a token on contract 0x3e2E325Ffd39BBFABdC227D31093b438584b7FC3 through contract 0x53bb77F35df71f463D1051061B105Aafb9A87ea1

:heavy_check_mark: Create on your contract a function claimToken() that receives a signed hash from the contract deployer and a token number to mint a token 

:x: Deploy bouncerProxy() contract and an ERC20 contract(). Whitelist an address A on the bouncer and credit 10 tokens to this address in the ERC20 

:x: Claim a token from your ERC721, through the bouncerProxy() by sending an authorization signed by A, in a TX sent by address B 

:x: Same as question 8, but address A must tip address B in ETH 

:x: Same as previous question 8, but address A must tip address B with ERC20 token deployed in question 7. 
