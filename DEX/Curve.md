<h1 align="center">Curve：DeFi世界的造血机器</h1>

`Curve`是DeFi世界规模最大的同质化代币去中心化交易所(DEX)，最初专门提供稳定币或锚定资产货币的做市商交易市场。其锁仓量超过DeFi世界总锁仓量的10%，长期在DeFi的DEX板块排名第一。

`Curve`作为交易所最大的优势是`StableSwap`，即稳定币的自动流动性提供商。Curve的资金池非常深厚，对于大额稳定币交易，Curve可以提供非常低的价格滑点与低交易费用。除此之外，真正让Curve发挥魅力的地方在于它的整个生态系统中代币经济模型的运转。

我们先来介绍Curve最专注的领域：稳定币交易。

## StableSwap

Curve最大的优势是低滑点，尤其是大额交易。在DeFi世界的交易如果涉及大额稳定币，Curve是最理想的交易所。为实现大额稳定币的低滑点交易的同时保证流动性，Curve调整了自己的做市曲线：

<div align="center">
<img title="" src="../assets/2022-09-06-15-09-23-image.png" alt="" width="495">
</div>

图中紫色的曲线是CPMM做市曲线，流动性优秀，但滑点较高，被`Uniswap`采用。红色的曲线是CSMM，无滑点，但容易发生流动性枯竭。蓝色的Curve的做市曲线介于两者之间，保证了稳定币的交易的低滑点的同时流动性不会枯竭。

做市曲线的斜率的相反数$-\frac{d_Y}{d_X}$即是代币X的价格，对于恒定和模型CSMM，代币的价格是恒定不变的。这对于稳定币交易非常有利，代价是流动性随时可能枯竭。一个简单的解决方案是引入价格预言机来实时调整恒定和的常数$K$，但这带来了额外的风险，且显著降低了去中心化程度。

对于恒定积模型(CPMM)，流动性池中的代币价格（以X为例）$P_X$很容易推导：

$$
X \times Y = K \\
P_X = -\frac{d_Y}{d_X} =\frac{K}{X^2} = \frac{Y}{X} 
$$

恒定积模型赋予了市场价格发现机制，即代币价格只和供需有关。LP向流动性池子提供流动性只会改变乘积K的大小，无论价格如何变动，代币X与代币Y的价值比依然是1:1，即投入流动性的时刻的价值比。简单的恒定积模型牺牲了交易滑点，价格的大幅变动意味着LP需要承受较大的无常损失。

假设$X$ 与$Y$价格相等时，总数为$D$，对于恒定和模型有：

$$
X + Y = D
$$

对于恒定积模型有：

$$
X \times Y = (\frac{D}{2})^2
$$

Curve的做市曲线是这样构建的，给恒定和模型两边乘上$\chi D$，加到恒定积模型上：

$$
\chi D(X + Y) + X Y = \chi D^2 + (\frac{D}{2})^2
$$

其中$\chi$是一个无量纲的变量：

$$
\chi = \frac{A XY}{(\frac{D}{2})^2}
$$

这里的A可以看作一个增益系数，这个增益系数决定了做市曲线中心的平坦度。简单地说，A越大，围绕当前价格的流动性集中程度就越高，做市策略越接近恒定和模型。

这里只考虑只有两种代币X与Y的流动性池，读者可以自行延拓至N种代币。

## Curve的DAO治理

Curve平台币`CRV`：同时拥有积累价值与投票的功能。

CRV总量为30.3亿个，其中62%分配给LP，流动性挖矿中的5%分配给CRV推出之前的LP，这5%有一年的解锁期。62%中的57%会在未来6年多时间内逐步释放给LP；总量中的30%分配给创世团队与投资者（解锁期为2~4年）；3%分配给Curve员工（2年的解锁期）；5%用作社区储备。

每天可以挖到76万个CRV，根据比例分配在每个池子里。

##### 投票

我们先来看投票的职能：

Curve的DAO投票采用了时间权重的机制，权重与锁定时间正相关，锁定时间有一个上限$t_{max}$：4年。投票的权重可以表示为：

$$
vote\  weight = a \frac{t}{tmax} 
$$

$t$是锁定时间，$a$是锁定CRV的金额，$t_{max}$为4年。

<div align="center">
<img title="" src="../assets/2022-09-06-17-10-06-image.png" alt="" width="385">
</div>

随着时间线性递减

任何拥有2000个veCRV的人可以发起提案。项目方可以通过这个方法吸引用户为自己的代币提供流动性，这也是“造血机器”称号的由来。

***

#### 价值积累

如何理解`CRV`的价值流通：

LP通过向流动性池注入资金提供流动性来获得一定的APY奖励。APY奖励有一个范围，可以通过锁仓`CRV`来获得`veCRV`来加速收益。

<div align="center">
<img src="../assets/2022-09-06-16-52-02-image.png" title="" alt="" width="701">
</div>

`veCRV`（voting-escrow CRV）是Curve平台的投票托管代币，是CRV锁仓后的凭证。一个CRV锁仓4年可以获得1个veCRV，锁仓时间越长，得到的veCRV就越多：


<div align="center">
<img title="" src="../assets/2022-09-06-17-28-14-image.png" alt="" width="693">

</div>

veCRV主要有四个用处：

- 投票

- (Base vAPY) 获得全平台对应比例的所有交易费的50%分红，以`3CRV`的形式累积给用户

- (Rewards tAPR) 流动性挖矿的奖励提高至2.5倍

- 获得一些项目的代币空投

<div align="center">
<img src="../assets/2022-09-07-00-35-05-image.png" title="" alt="" width="634">
</div>

3CRV是Curve知名的“3pool”的LP凭证。用户在提取收益时，可以将3CRV兑换成任何一种稳定币资产：


<div align="center">
<img src="../assets/2022-09-07-00-41-33-image.png" title="" alt="" width="195">
</div>

锁仓凭证veCRV虽然不可交易，但Curve为其赋予了价值：

$$
veCRV = 治理_{(投票权)} + 收益_{(3CRV + ~2.5 \times boost APY + Airdrop)}
$$

一方面，veCRV的价值是靠CRV锁仓换来的，这使得CRV在公开市场上变得稀缺。另一方面，veCRV的效用是随时间衰减的，用户想要高收益就要持续锁仓CRV来维持veCRV的作用，这也增强了CRV的持有者的粘性。Curve的代币经济系统是一个自我强化的循环。

<div align="center">
<img title="" src="../assets/2022-09-07-00-49-27-image.png" alt="" width="302">
</div>


<div align="center">
<img title="" src="../assets/c2c403e76ef28d866c330147e252c13917e544d0.png" alt="" width="1010">
</div>

## Convex: Curve生态的拓展

convex的核心创新点是把Curve的veCRV的治理权与收益权分离，分离成两种Convex平台代币`vlCVX`和`cvxCRV`。

<div align="center"> 
<img src="../assets/2022-09-07-01-18-09-image.png" title="" alt="" width="489">
</div>

convex用户通过质押CRV可以获得cvxCRV代币，这种质押是不可逆的。cvxCRV

<div align="center"> 
<img src="../assets/2022-09-07-01-10-31-image.png" title="" alt="" width="482">
</div>

![](../assets/2022-09-07-01-12-58-image.png)

<div align="center"> 
<img src="../assets/2022-09-07-01-14-12-image.png" title="" alt="" width="754">
</div>
