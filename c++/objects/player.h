#include <string>
#include <stdlib.h>
#include <iostream>

using namespace std;

class player
{
	public:
		player();
		player(string inputName);
		void Greet();
		string name;
};
