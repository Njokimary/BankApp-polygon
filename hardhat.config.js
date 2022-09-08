require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    hardhat:{},
    mumbai:{
      url:"https://polygon-mumbai.g.alchemy.com/v2/2j3CWWLEEYU1LzYIRwbhzNNnusYb24o3",
      accounts:["d158fb831c245fc03faeb3bd3c33c6911bf6beec35daf3e860ab2f9f56e47cfd"],
      chainId:80001,
    },
  },
  solidity: "0.8.9",
};
