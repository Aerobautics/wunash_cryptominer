# WuNash CryptoMiner
by Stewart Nash and Andy Wu

## Introduction
The goals of this project are to create a cryptocurrency miner using both the Xilinx FPGA and the Altera FPGA. We will begin with the Xilinx FPGA and also demonstrate that this design can be duplicated with an Intel FPGA. We will complete this design using only free or open source software. Parts will be ordered from [DigiKey](http://www.digikey.com). Electronic design will be done in [OrCAD](http://www.orcad.com). Chassis design will be done in [FreeCAD](http://www.freecadweb.org).

The goals are to maximize the production of Bitcoin using a single FPGA. In the future, we may attempt to remaster the design for other cryptocurrencies.

## Background
### Bitcoin and the blockchain
Bitcoin is a cryptocurrency that is distributed on a peer-to-peer network. Transactions are verified by cruptography and recorded on a blockchain. The blockchain is public ledger for recording bitcoin transactions.
### Bitcoin mining
Miners offer verification of transactions by issuing blocks, an aggregation of new transactions. The blocks are transmitted to the Bitcoin network and verified by individual nodes. Every block contains a SHA-256 hash of the previous block. Miners must generate proof-of-work as a nonce. Miners are paid (by themselves) a transaction fee and newly minted bitcoin. Bitcoin minting is halved every 210,000 blocks.
### Pooling
Bitcoin mining is often distributed among various miners and payment is distributed based on the amount of work each miner in the pool performed.

## SHA-256
SHA-256 is a variant of the SHA-2 hash function. It is computed with a 32-bit word.
The SHA-256 algorithm is as follows:
1. The algorithm starts with the introduction of the fractional part of the square root of the first 8 primes (2, 3, 5, 7, 9, 11, 13, 17, 19):
```
0x6a09e667
0xbb67ae85
0x3c6ef372
0xa54ff53a
0x510e527f
0x9b05688c
0x1f83d9ab
0x5be0cd19
```
2. An array is then initialized with the first 32 bits of the fractional parts of the cube roots of the first 64 primes (2 to 311):
```
0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
```
   1. The bit 1 is appended to the message of length L
3. K bits 0 are appended wher K is the smallest non-negative integer s.t. L + K + 1 + 64 = n * 512 for some positive integer n
3. Append the length L as a 64 bit big-endian integer to make the total length n * 512
3. Break the message into 512 bit chunks
3. For each chunk
	3. Create a 64 entry message schedule array of 32 bit words (with don't care initial entries)
	3. Copy the chunck into the first 16 words of the message schedule array
	3. Extend the first 16 words into the remaining 48 words of the message schedule array
	3. Initialize the working variable to the current hash value
	3. Compress the chunks
	3. Add the compressed chunks to the current hash value
3. The final hash is produced by concatenating the 8 hash values
	
## TODO
1. Translate the SHA-256 algorithm pseudocode to C++
1. Implement C++ mining bitcoin miner
1. Implement C++ pooled mining
