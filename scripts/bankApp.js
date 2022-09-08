const hre = require("hardhat");

async function main() {
    //body
    const signers = await hre.ethers.getSigners();
    //console.log("Signers::",signers);
    
    const account0 = signers[0].address;
    const account1 = signers[1].address;
    const BankApp = await hre.ethers.getContractFactory("BankApp");
    const bankApp = await BankApp.deploy("Mary");
    await bankApp .deployed();
    
    await bankApp.register(account0,1234,"Andrea","sah567",1008);
    await bankApp.register(account1,6789,"john","sAgh567",30);

  //login the user
    await bankApp.connect(signers[0]).login()

    const deposited =await bankApp.deposit(3000)
    await bankApp.withdraw(1500)
    const balance1 =await bankApp.balanceof(account0)
    //console.log(deposited)
    console.log(balance1)
    //transfer function call
    await bankApp.connect(signers[0]).transfer(account1,100)
    const balance2 =await bankApp.balanceof(account0)
    console.log(balance2)

} 

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });