#WuNash CryptoMiner

by Stewart Nash and Andy Wu

##Introduction
The goals of this project are to create a cryptocurrency miner using both the Xilinx FPGA and the Altera FPGA. We will begin with the Xilinx FPGA and also demonstrate that this design can be duplicated with an Intel FPGA. We will complete this design using only free or open source software. Parts will be ordered from [DigiKey](http://www.digikey.com). Electronic design will be done in [OrCAD](http://www.orcad.com). Chassis design will be done in [FreeCAD](http://www.freecadweb.org).

The goals are to maximize the production of Bitcoin using a single FPGA. In the future, we may attempt to remaster the design for other cryptocurrencies.

##Background

###Bitcoin
Bitcoin is a cryptocurrency that is distributed on a peer-to-peer network. Transactions are verified by cruptography and recorded on a blockchain. The blockchain is public ledger for recording bitcoin transactions.

###Mining
Miners may either participate in solo mining or pooled mining. The mining software periodically polls bitcoind to obtain new transactions with the getblocktemplate RPC which will give a list of new transactions and a public key to send the coinbase transactions to. The mining software will construct a block using a template and create block header which is ent to the minign hardware with a target threshold. The mining hardware searches for a block header nonce that satisfies the criterion. If successful, the mining software will combine the header with the block and transmit it through bitcoind for network broadcast and addition to the block chain.
In pooled mining, shares are created and sent to the mining pool. The shares are below the target threshold, but if it meets the threshold, it will be sent to the network and added to the blockchain.

###Blockhain
Each full node in the Bitcoin network stores a block chain which it has verified independently. Several nodes are in consensus when their blocks agree with eachother. Consensus rules are used by the nodes to validate their blocks.
Each block stores a merkle root in its header as well as a hash of the previous block's header. Transactions are also chained together, with the input of one transaction consisting of the output of a previous transaction. The outputs are marked by a transaction identifier, which is a hash of the signed transaction. Any overage of the input from the output can be claimed by miners as a transaction fee. 

###Transactions
A coinbase transaction is the first transaction in the block. It is created by a Bitcoin miner. The Bitcoin miner charges a transaction fee.
	
##TODO
1. Write the C++ code for the SHA-256 algorithm



