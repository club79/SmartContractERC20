var UmbalaCrowdsale = artifacts.require("./UmbalaCrowdsale.sol");

module.exports = function(deployer) {
  const startTime = Math.round((new Date(Date.now() - 86400000).getTime())/1000); // Yesterday
  const endTime = Math.round((new Date().getTime() + (86400000 * 20))/1000); // Today + 20 days
  //const endTime = Math.round((new Date().getTime() + (86400000 / 24 / 4))/1000); // Today + 20 days

  deployer.deploy(UmbalaCrowdsale, 
    startTime, 
    endTime,
    5, 
    "0x6f8d5b0a340c7761be0dc8117f828b2327a53aed", 
    "0x34d9d097cdad8cd3d1e03ebc225970d925f5aecc",
    "0x7aec185432310fff0deb5a20cbddb8e2ab06c099",
    2000000000000000000,
    500000000000000000000 
  );
  console.log("params : ", JSON.stringify([startTime, endTime]));
};

// var web3 = require('web3-eth-abi');
// web3.encodeParameters(
//   ['uint256', 'uint256', 'uint256', 'address','address','address','uint256','uint256'],
//   [1522046554,1523860954,5,"0x6f8d5b0a340c7761be0dc8117f828b2327a53aed","0x34d9d097cdad8cd3d1e03ebc225970d925f5aecc","0x7aec185432310fff0deb5a20cbddb8e2ab06c099",2000000000000000000,500000000000000000000]);