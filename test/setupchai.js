'use strict'

require("dotenv").config({path: "../.env" });
var Chai = require("chai");
const BN = web3.utils.BN;
const chaiBn = require("chai-bn")(BN);
let chaiAsPromised;

before(async () => {
  chaiAsPromised = (await import("chai-as-promised")).default;
  Chai.use(chaiBn);
  Chai.use(chaiAsPromised);
});

module.exports = Chai;