const { expect } = require("chai");

describe("DokoCore", function() {
  it("Should return the new greeting once it's changed", async function() {
    const DokoCore = await ethers.getContractFactory("DokoCore");
    const dokocore = await DokoCore.deploy();
    await dokocore.deployed();

    const mintTx = await dokocore.mint();
    
    // wait until the transaction is mined
    await mintTx.wait();

  });
});
