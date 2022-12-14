<h1 align="center">借贷</h1>

<div align="center">
<img title="" src="assets/2022-08-31-11-30-10-image.png" alt="" width="753" data-align="center">
</div>

### 基本术语：

<div align="center">
<img title="" src="assets/2022-08-31-11-38-55-image.png" alt="" width="539" data-align="center">

<img title="" src="assets/2022-08-31-11-40-20-image.png" alt="" width="668" data-align="center">
</div>

清算过程任何人都可以发起，获得相应的清算奖励。但清算常常不是立即发起的，延迟 48 小时或 72 小时是常见的策略。在这个窗口期内，借贷者可以完成补仓操作。这对借贷方来说可以避免巨大的损失，协议方也可以规避巨大的波动。

关于清算需要了解的一些术语：

<div align="center">
<img title="" src="assets/2022-08-31-12-17-49-image.png" alt="" width="906" data-align="center">
</div>

清算价差是激励清算者的机制，关闭因子一般被设置为一个常数，比如 0.5，这意味着清算人最多可以偿还 50%的债务。

## 超额抵押借贷

/// todo!

## 不足额抵押

<div align="center">
<img title="" src="assets/2022-08-31-14-28-32-image.png" alt="" width="719" data-align="center">
</div>

拉高杠杆的不足额抵押借款已经被市场抛弃。究其原因是风险偏高：一旦债务币种价格升高，不足额抵押借款的收益很可能转负。此外，借债智能用来做智能合约允许的事情（比如参加流动性挖矿）。流动性挖矿有无常损失，且获得收益较慢。在较长的时间范围内，债务资产的币价波动很可能导致借款人被清算，即使不被清算，本金亏损的情况也常常发生。

# 清算

<div align="center">
<img title="" src="assets/2022-08-31-15-06-55-image.png" alt="" width="544" data-align="center">

<img title="" src="assets/2022-08-31-15-11-30-image.png" alt="" width="660" data-align="center">
</div>

英式拍卖：固定时间内出价高者得

<img title="" src="assets/2022-08-31-15-13-27-image.png" alt="" width="672" data-align="center">

拍卖清算会分成两个部分：账面阶段与还款阶段。在账面阶段，清算人出价的偿还债务越来越高；偿还阶段，索取抵押物的比例越来越低。债务 D 需要全部偿还，但只能获取一部分抵押物。

荷兰式拍卖：一笔交易中立即结算

<div align="center">
<img title="" src="assets/2022-08-31-15-25-01-image.png" alt="" width="691" data-align="center">
</div>

目前清算工作已经完全由智能合约来完成。

<div align="center">
<img title="" src="assets/2022-08-31-15-34-24-image.png" alt="" width="612" data-align="center">
</div>

清算过程对抵押物价格的下跌是正反馈的，进而引发进一步的清算与抵押物价格下跌。

## 闪电贷 (flash loan)

智能合约的特性为用户提供了闪电贷的能力，这在传统金融中是不可能出现的。

闪电贷要求一笔借贷在一个原子交易内完成。借贷人获取一笔无需抵押的贷款，完成一系列操作之后（大部分是套利操作），在同一笔交易内偿还本金、利息与 gas 即可完成闪电贷。

假如偿还失败，该笔交易会回滚，相当于这笔交易并没有发生，这对于借款的协议来说，并无风险。

<div align="center">
<img title="" src="assets/2022-08-31-15-44-09-image.png" alt="" width="677" data-align="center">

<img title="" src="assets/2022-08-31-15-45-37-image.png" alt="" width="665" data-align="center">
</div>

当前利用价格预言机进行 DeFi 攻击的行为已经不再常见了。合约部署方可以这样防范攻击：

> 现在很少听到通过闪电贷通过预言机操纵攻击了，不是因为 Chainlink 的普及，而是一个合约部署方在使用预言机方式上的一个小改进，就是对价格做一个小延迟。闪电贷必须在一笔交易中完成，因此黑客对预言机价格的操纵也必须在同一笔交易里完成。所以如果我们的喂价，是用上一个时刻的价格，会怎么样呢？黑客用闪电贷把某币的价格从 1 刀拉到了 10000 刀，企图以 10000 刀进行交易，但结果他进行的这笔交易是用上一个时刻预言机产生的价格，那他的攻击就无法进行了。

### 闪电贷如何套利：

<div align="center">
<img title="" src="assets/2022-08-31-15-54-11-image.png" alt="" width="727" data-align="center">
</div>

不同的池子之间存在价差（套利空间），从 dYdX 借出一笔大额 USDC，从低价池子中购买 DAI，在高价池子中卖掉 DAI 换回 USDC，其中的差价减去借贷利息与 gas 就是此次闪电贷的利润。
