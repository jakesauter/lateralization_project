#include <iostream>

using namespace std;

int operator+(int left, int right)
{
	return (left*right);
}

int main()
{	
	int x=2, y=3;
	cout << x+y << endl;
	return 0;
}
