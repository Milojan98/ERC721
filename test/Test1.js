const { debug } = require("console");

const parametersEncoded = web3.eth.abi.encodeParameters(['bytes32'], ["0x596f75206e65656420746f207369676e207468697320737472696e6700000000"]);
const signature = web3.eth.accounts.sign(parametersEncoded,"0xce38a2816e4511bcb1de0e03badab1b0a6064bfc6e323cb9ff83f4836927e891");
console.log("signature: ", signature);