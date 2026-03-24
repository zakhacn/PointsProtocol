# Gas-Optimized Points Protocol

A high-performance Solidity smart contract for managing digital points, built and tested with **Foundry**.

## 🚀 Key Features
- **Gas Efficiency:** Utilized variable packing (uint64 for timestamps) and custom errors to minimize execution costs.
- **Security-First:** Implemented strict access controls for allowances, preventing common 'approve' vulnerabilities.
- **Full Test Suite:** 100% branch coverage including edge-case testing and exploit simulations.

## 🛠 Tech Stack
- **Language:** Solidity ^0.8.26
- **Toolchain:** Foundry (Forge, Cast, Anvil)
- **Deployment:** Sepolia Testnet

## 📊 Gas after optimized.

╭------------------------------------------------+-----------------+-------+--------+-------+---------╮
| src/PointsContract.sol:PointsContract Contract |                 |       |        |       |         |
+=====================================================================================================+
| Deployment Cost                                | Deployment Size |       |        |       |         |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| 1441103                                        | 6546            |       |        |       |         |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
|                                                |                 |       |        |       |         |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| Function Name                                  | Min             | Avg   | Median | Max   | # Calls |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| Withdraw                                       | 28413           | 28413 | 28413  | 28413 | 1       |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| approvebug                                     | 44655           | 44664 | 44667  | 44667 | 257     |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| buyPoints                                      | 43707           | 43707 | 43707  | 43707 | 4       |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| getBalance                                     | 2917            | 2917  | 2917   | 2917  | 515     |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| transfer                                       | 51561           | 51561 | 51561  | 51561 | 1       |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| transferFrom                                   | 47805           | 52383 | 52629  | 52629 | 257     |
╰------------------------------------------------+-----------------+-------+--------+-------+---------╯


## 🛡 Security Audit
Included in `test/Exploit.t.sol` is a simulation of a "Broken Access Control" vulnerability. I successfully identified a logic flaw in the `approve` mechanism and refactored the code to enforce `msg.sender` sovereignty.
