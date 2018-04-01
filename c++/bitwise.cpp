#include <iostream>
#include <string>
using namespace std;

int main()
{
	string plaintext; //message
	string key;//passphrase
	string ciphertext = "";//Encrypted Message (plaintext ^ key)
	cout << "Plain text: ";
	cin >> plaintext;
	cout << "Encryption key: ";
	cin >> key;
	if(plaintext.length() > key.length())
	{
		cout << "Encryption is not possible, key must be atleast as long as the message" << endl;
		return 0;
	}
	//to get the bit length of a key, it takes 8 bits to store a character
	if(key.length() * 8 < 96)
	{
		cout << "The key is considered weak" << endl;
	}
	char l1, l2;
	for(int i=0;i<plaintext.length();i++)
	{
		l1= plaintext[i];
		l2 = key[i];	
		ciphertext+=(char)(((l1)(int)) ^ ((l2)(int)));
	}
	cout << "Encrypted message: " << ciphertext << endl;
	string original = "";//cyphertext^key
	for(int i=0;i<ciphertext.length();i++)
	{
		l1= ciphertext[i];
		l2 = key[i];	
		original+=(char)(((l1)(int)) ^ ((l2)(int)));
	}
	return 1;

}

/*
int main()
{
   /*int x, y;
   cout << "X: ";
   cin >> x;
   cout << "Y: ";
   cin >> y;
   cout << "X & Y = " << (x & y) << endl;
   cout << "X | Y = " << (x | y) << endl;
   cout << "X ^ Y = " << (x ^ y) << endl;
   
   //new program
   int num[10];//numbers to computer the checksum for
   int checksum = 0;
   for(int i=0;i<10;i++)
   {
	cout << "num[" << i << "] : ;
	cin >> num[i];
	checksum = checksum ^ num[i];//keeping a running checksum
   }
   cout << "Checksum = " << checksum << endl;
   //exor is a reversable operation, 10^3=9 and 10^9 = 3
   return 1;
}
*/
