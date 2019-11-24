/* File: main.cpp
 * Date: November 11, 2019
 * Author: Stewart Nash
 * Description: This is a placeholder for the initial SHA-256 algorithm
 */
#include <iostream>
#include <vector>
#include <cassert>
#include <string>
#include <cstdlib>
#define HASH_SIZE 32
#define DEBUG_VERSION

inline uint32_t right_rotate(uint32_t input, uint32_t n);

void test_function_001();
void test_sha(std::vector<unsigned char> input, unsigned char output[HASH_SIZE]);
std::vector<unsigned char> decimateInteger(int input, int array_size);
void packChunk(std::vector<unsigned char> input, unsigned int output[]);

int main(int argc, char *argv[]) {
	test_function_001();
	test_function_001();

	system("pause");
	return 0;
}

/*
* (1) All variables are 32 bit unsigned integers and addition is calculated modulo 2 ^32
* (2) For each round, there is one round constant k[i] and one entry in the message schedule array w[i], 0<=i<=63
* (3) The complression function uses 8 working variables, a through h
* (4) Big-endian convention is used when expressing the constants in this pseudocode, and when parsing message block data from bytes to words, for example, the first word of the input message "abc" after padding is 0x61626380, 'a'=0x61
*/
void test_function_001() {
	unsigned char test_hash[HASH_SIZE];
	std::string test_string = "Hello, World!";
	//dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f
	std::vector<unsigned char> input;
	std::string output;

	//test_string.erase(std::find(test_string.begin(), test_string.end(), '\0'), test_string.end());
	input.insert(input.end(), test_string.begin(), test_string.end());
	std::cout << test_string << std::endl;
	test_sha(input, test_hash);
	for (int i = 0; i < HASH_SIZE; i++) {
		std::cout << std::hex << static_cast<int>(test_hash[i]);
	}
	std::cout << std::endl;
}

void test_sha(std::vector<unsigned char> input, unsigned char output[HASH_SIZE]) {
	const int HASH_COUNT = 8;
	const int ROUND_COUNT = 64;
	const int BIT_COUNT = 512;
	const int BYTE_COUNT = 4;
	const unsigned int END_SIZE = 64;
	const int WORD_SIZE = 8;
	const unsigned char FIRST_WORD = 0x80;
	//const unsigned int FIRST_WORD = 0b10000000;
	unsigned int messageLength;
	unsigned int appendageLength;
	unsigned int totalLength;
	int additions;
	int iterations;
	bool isMatchFound;
	std::vector<unsigned char> tail;
	std::vector<unsigned char> temporary;
	uint32_t workingVariables[HASH_COUNT];
	uint32_t messageScheduleArray[ROUND_COUNT];

	
	// Initialize hash values with the first 32 bits of
	// the fractional parts of the square roots of the first 8 primes
	uint32_t hashValues[HASH_COUNT] = {
		0x6A09E667,
		0xBB67AE85,
		0x3C6EF372,
		0xA54FF53A,
		0x510E527F,
		0x9B05688C,
		0x1F83D9AB,
		0x5BE0CD19
	};
	
	// Initialize array of round constants with the first 32 bits of
	// the fractional parts of the cube roots of the first 64 primes
	uint32_t roundConstants[ROUND_COUNT] = {
		0x428a2f98,
		0x71374491,
		0xb5c0fbcf,
		0xe9b5dba5,
		0x3956c25b,
		0x59f111f1,
		0x923f82a4,
		0xab1c5ed5,
		0xd807aa98,
		0x12835b01,
		0x243185be,
		0x550c7dc3,
		0x72be5d74,
		0x80deb1fe,
		0x9bdc06a7,
		0xc19bf174,
		0xe49b69c1,
		0xefbe4786,
		0x0fc19dc6,
		0x240ca1cc,
		0x2de92c6f,
		0x4a7484aa,
		0x5cb0a9dc,
		0x76f988da,
		0x983e5152,
		0xa831c66d,
		0xb00327c8,
		0xbf597fc7,
		0xc6e00bf3,
		0xd5a79147,
		0x06ca6351,
		0x14292967,
		0x27b70a85,
		0x2e1b2138,
		0x4d2c6dfc,
		0x53380d13,
		0x650a7354,
		0x766a0abb,
		0x81c2c92e,
		0x92722c85,
		0xa2bfe8a1,
		0xa81a664b,
		0xc24b8b70,
		0xc76c51a3,
		0xd192e819,
		0xd6990624,
		0xf40e3585,
		0x106aa070,
		0x19a4c116,
		0x1e376c08,
		0x2748774c,
		0x34b0bcb5,
		0x391c0cb3,
		0x4ed8aa4a,
		0x5b9cca4f,
		0x682e6ff3,
		0x748f82ee,
		0x78a5636f,
		0x84c87814,
		0x8cc70208,
		0x90befffa,
		0xa4506ceb,
		0xbef9a3f7,
		0xc67178f2
	};

	// To original message of L bits append bit '1' and K bits '0'
	// K >= 0 such that L + 1 + K + 64 = n * 512 and
	// append L as a 64-bit big-endian integer for n * 512 bits
	isMatchFound = false;
	appendageLength = 0;
	messageLength = input.size() * WORD_SIZE;
	do {
		totalLength = messageLength + 1 + appendageLength + END_SIZE;
		if (!(totalLength % BIT_COUNT)) {
			isMatchFound = true;
		} else {
			++appendageLength;
		}
		//TODO Error out if appendageLength exceeds 512
		#ifdef DEBUG_VERSION
		assert(appendageLength < BIT_COUNT);
		#endif
	} while(!isMatchFound);
	totalLength = 1 + appendageLength;
	#ifdef DEBUG_VERSION
	assert(!(totalLength % WORD_SIZE) && totalLength >= WORD_SIZE);
	#endif
	additions = totalLength / WORD_SIZE;
	for (int i = 0; i < additions; i++) {
		if (i == 0) {
			input.push_back(FIRST_WORD);
		} else {
			input.push_back(0);
		}
	}
	tail = decimateInteger(messageLength, END_SIZE);
	input.insert(input.end(), tail.begin(), tail.end());
	// Break the message into 512 bit chunks
	iterations = input.size() / (BIT_COUNT / WORD_SIZE);
	for (int i = 0; i < iterations; i++) {
		// Breaking off a 512b chunk . . .
		temporary = std::vector<unsigned char>(input.begin() + i * (BIT_COUNT / WORD_SIZE),
			input.begin() + (i + 1) * (BIT_COUNT / WORD_SIZE));
		// Create a 64-entry message schedule array (MSA) of 32-bit words
		//unsigned int messageScheduleArray[ROUND_COUNT];
		// Copy chunk into first 16 words of MSA
		packChunk(temporary, messageScheduleArray);
		// Extend the first 16 words into the remaining 48 words of the MSA
		for (int j = BIT_COUNT / (BYTE_COUNT * WORD_SIZE); j < ROUND_COUNT; j++) {
			uint32_t seed_0 = right_rotate(messageScheduleArray[j - 15], 7) ^
				right_rotate(messageScheduleArray[j - 15], 18) ^
				(messageScheduleArray[j - 15] >> 3);
			uint32_t seed_1 = right_rotate(workingVariables[j - 2], 17) ^
				right_rotate(messageScheduleArray[j - 2], 19) ^
				(messageScheduleArray[j - 2] >> 10);
			messageScheduleArray[j] = messageScheduleArray[j - 16] + seed_0 +
				messageScheduleArray[j - 7] + seed_1;
		}
		// Initialize working variables to current hash value
		for (int j = 0; j < HASH_COUNT; j++) {
			workingVariables[j] = hashValues[j];
		}

		// a = 0, b = 1, c = 2, d = 3
		// e = 4, f = 5, g = 6, h = 7
		// Main compression function
		for (int j = 0; j < ROUND_COUNT; j++) {
			uint32_t seed_0 = 0;
			uint32_t seed_1 = 0;
			uint32_t temporary_1 = 0;
			uint32_t temporary_2 = 0;
			uint32_t ch;
			uint32_t maj;

			seed_1 = right_rotate(workingVariables[4], 6) ^
				right_rotate(workingVariables[4], 11) ^
				right_rotate(workingVariables[4], 25);
			ch = (workingVariables[4] & workingVariables[5]) ^
				((~workingVariables[4]) & workingVariables[6]);
			temporary_1 = workingVariables[7] + seed_1 + ch +
				roundConstants[j] + messageScheduleArray[j];
			seed_0 = right_rotate(workingVariables[0], 2) ^
				right_rotate(workingVariables[0], 13) ^
				right_rotate(workingVariables[0], 22);
			maj = (workingVariables[0] & workingVariables[1]) ^
				(workingVariables[0] & workingVariables[2]) ^
				(workingVariables[1] & workingVariables[2]);
			temporary_2 = seed_0 + maj;

			workingVariables[7] = workingVariables[6];
			workingVariables[6] = workingVariables[5];
			workingVariables[5] = workingVariables[4];
			workingVariables[4] = workingVariables[3] + temporary_1;
			workingVariables[3] = workingVariables[2];
			workingVariables[2] = workingVariables[1];
			workingVariables[1] = workingVariables[0];
			workingVariables[0] = temporary_1 + temporary_2;
		}
		// Add the compressed chunk to the current hash value
		for (int j = 0; j < HASH_COUNT; j++) {
			hashValues[j] = hashValues[j] + workingVariables[j];
		}
	}
	// Produce the final hash value (big-endian)
	for (int i = 0; i < HASH_COUNT; i++) {
		temporary = decimateInteger(hashValues[i], BYTE_COUNT);
		//output.insert(output.end(), temporary.begin(), temporary.end());
		output[i * BYTE_COUNT + 0] = temporary[0];
		output[i * BYTE_COUNT + 1] = temporary[1];
		output[i * BYTE_COUNT + 2] = temporary[2];
		output[i * BYTE_COUNT + 3] = temporary[3];		
	}
}

// Put integer into a character array (vector)
std::vector<unsigned char> decimateInteger(int input, int array_size) {
	std::vector<unsigned char> output;
	const int MAXIMUM_WORD = 0x100;

	for (int i = 0; i < array_size; i++) {
		output.push_back(input % MAXIMUM_WORD);
		input = input / MAXIMUM_WORD;
	}
	std::reverse(output.begin(), output.end());

	return output;
}

void packChunk(std::vector<unsigned char> input, unsigned int output[]) {
	const int BIT_COUNT = 512;
	const int BYTE_COUNT = 4;
	const int WORD_SIZE = 8;
	const unsigned int MAXIMUM_WORD = 0x100;
	unsigned int temporary;

	for (int i = 0; i < input.size() / BYTE_COUNT; i++) {
		temporary = input[i * BYTE_COUNT + 0];
		temporary *= MAXIMUM_WORD; // Same as left shift by 8
		temporary += input[i * BYTE_COUNT + 1]; 		
		temporary *= MAXIMUM_WORD; // Same as left shift by 8
		temporary += input[i * BYTE_COUNT + 2];
		temporary *= MAXIMUM_WORD; // Same as left shift by 8
		temporary += input[i * BYTE_COUNT + 3];
		output[i] = temporary;
	}
}

inline uint32_t right_rotate(uint32_t input, uint32_t n) {
	return (input << n) | (input >> (32 - n));
}


