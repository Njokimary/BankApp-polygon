
const hre = require("hardhat");

const bankAppAbi = require("./abi/bankAppAbi");

async function main() {
  const signers = await hre.ethers.getSigners();
   const contractAddress="0x65C71f705aa510B7A4fED0c0660416774FA0B8C8"
   const account0 = signers[0].address;
   const account1 ="0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6"
   //metamask address
   console.log("my address",signers[0].address);
   //create new instance of  our bank App contract
   const bankAppContract =new hre.ethers.Contract(contractAddress,bankAppAbi,signers[0].provider);
   //register new account
   console.log("deposit-Res:", await bankAppContract.connect(signers[0]).deposit(4000));

}



    main().catch((error) => {
        console.error(error);
        process.exitCode = 1;
      });