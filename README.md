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

## 📊 Gas Snapshot

╭------------------------------------------------+-----------------+-------+--------+-------+---------╮
| src/PointsContract.sol:PointsContract Contract |                 |       |        |       |         |
+=====================================================================================================+
| Deployment Cost                                | Deployment Size |       |        |       |         |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| 1505454                                        | 6845            |       |        |       |         |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
|                                                |                 |       |        |       |         |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| Function Name                                  | Min             | Avg   | Median | Max   | # Calls |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| Withdraw                                       | 28413           | 28413 | 28413  | 28413 | 1       |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| approvebug                                     | 44655           | 44664 | 44667  | 44667 | 257     |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| buyPoints                                      | 43695           | 43695 | 43695  | 43695 | 4       |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| getBalance                                     | 2917            | 2917  | 2917   | 2917  | 515     |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| transfer                                       | 51907           | 51907 | 51907  | 51907 | 1       |
|------------------------------------------------+-----------------+-------+--------+-------+---------|
| transferFrom                                   | 48342           | 53051 | 53166  | 53166 | 257     |
╰------------------------------------------------+-----------------+-------+--------+-------+---------╯



## 🛡 Security Audit
Included in `test/Exploit.t.sol` is a simulation of a "Broken Access Control" vulnerability. I successfully identified a logic flaw in the `approve` mechanism and refactored the code to enforce `msg.sender` sovereignty.
