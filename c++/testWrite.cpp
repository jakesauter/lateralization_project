#include <iostream>
#include <fstream>

using namespace std;

int main()
{
	ofstream out;
	out.open("save.txt");
	out << "test test 123" << endl;
	out.close();
	return 0;
}
