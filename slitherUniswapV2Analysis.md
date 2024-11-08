# Analysing slither output on Uniswap V2

---

### I. RED

#### 1. uses arbitrary from in transferFrom

In flashLoan:

```solidity
transferBackSuccess = IERC20(token).transferFrom(address(receiver), address(this), amount + fee);
```

#### 2. ERC20 is re-used

In the lib folder there are two contracts with the same name ERC20, one from solady, one from openzeppelin. The documentation says

> If a codebase has two contracts the similar names, the compilation artifacts will not contain one of the contracts with the duplicate name.
> However, we only use the solady contract so that is not a problem.

#### 3. price1CumulativeLast is never initialized

price1CumulativeLast should be initialized to zero. However in solidity all variables are automatically initialized to zero so to save gas there is no need to initialize price1CumulativeLast. The slither documentation says

> If a variable is meant to be initialized to zero, explicitly set it to zero to improve code readability.

---

### II. YELLOW

#### 1. \_swap performs a multiplication on the result of a division

In \_swap :

```solidity
leftSide = (((1000 * balanceIn - FEE_BASIS_POINTS * amountIn) / 1_000_000_000) * balanceOut)
rightSide = (((1000 * reserveIn) / 1_000_000_000) * reserveOut)
```

This was intended to remove overflow but is not ideal.

#### 2. Reentrancy danger

All the function having external calls raise the reeantrancy warning, however the nonReentrant modifier has already been put in place to protect agains this vulnerability.
