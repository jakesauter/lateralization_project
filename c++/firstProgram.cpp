#include <iostream>
#include <string>

using namespace std;

int main()
{	
	string name = "";
	string advice = "Use a toaster shield, fight!";
	cout << "Whats your name?: ";
	cin >> name;
	cout << "You want my advice " << name << "?" << endl;
	cout << "My advice: " << advice << endl;
	return 0;
}
