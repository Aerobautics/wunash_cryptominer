#include <stdio.h>
#include <cmath>
#include <iostream>

using namespace std;

void fractionalToHex(char* hexArr, double decimal);
char intToHex(double decimal);


int main()
{
	//Testing fractionalToHex of 2^(1/2)
	//Output: 6a09e667
	char hex[8] = {};
	fractionalToHex(hex, pow(2, .5));
	for(int i = 0; i < 8; i++)
	{
	    cout << hex[i];
	}
	
	
	return 0;
}

void fractionalToHex(char* hexArr, double decimal)
{
    double intPart, fractPart;
    double temp;
    
    temp = decimal;
    
    for(int i = 0; i < 8; i++)
    {
        fractPart = modf(temp, &intPart);
        temp = fractPart * 16;
        modf(temp, &intPart);
        hexArr[i] = intToHex(intPart);
    }
}

char intToHex(double decimal)
{
    char hex;
    int dec =  decimal;
    switch(dec)
    {
        case 0: hex = '0';
            break;
        case 1: hex = '1';
            break;
        case 2: hex = '2';
            break;
        case 3: hex = '3';
            break;
        case 4: hex = '4';
            break;
        case 5: hex = '5';
            break;
        case 6: hex = '6';
            break;
        case 7: hex = '7';
            break;
        case 8: hex = '8';
            break;
        case 9: hex = '9';
            break;
        case 10: hex = 'a';
            break;
        case 11: hex = 'b';
            break;
        case 12: hex = 'c';
            break;
        case 13: hex = 'd';
            break;
        case 14: hex = 'e';
            break;
        case 15: hex = 'f';
            break;
        default: hex = 'z';
    }
    
    return hex;
    
}
