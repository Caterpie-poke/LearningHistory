const LearningLogs = artifacts.require("LearningLogs");

module.exports = function (deployer) {
    deployer.deploy(LearningLogs, { gas: 2000000 });
};
