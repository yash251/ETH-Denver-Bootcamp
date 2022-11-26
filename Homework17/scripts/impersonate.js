const {ethers} = require("hardhat");

// Get Vitalik account - address 0x220866B1A2219f40e72f5c628B65D54268cA3A9D
async function runBlockchain() {
    console.log("Before transfer...");
    console.log("-------------------------------------")
    const vitalikAccount = await ethers.getImpersonatedSigner("0x220866B1A2219f40e72f5c628B65D54268cA3A9D");
    const vitalikBalance = await vitalikAccount.getBalance();
    console.log("Vitalik balance :", vitalikBalance);

    // get team account balance
    const teamAccount = await ethers.getImpersonatedSigner("//0x");
    const teamAccountBalance = await teamAccount.getBalance();
    console.log("team balance: ", teamAccountBalance);
    // transfer
    const transactionResponse = await vitalikAccount.sendTransaction(
        {to: teamAccount.address,
        value: ethers.utils.parseEther("289000"),
        });
    console.log("Transferring...")
    await transactionResponse.wait(1);
    console.log("------------------------------------")
    console.log("New balances after transfer...")
    const newVitalikBalance = await vitalikAccount.getBalance();
    const newTeamBalance = await teamAccount.getBalance();
    console.log("Vitalik new balance: ", newVitalikBalance);
    console.log("team new balance: ", newTeamBalance);
}

runBlockchain()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
