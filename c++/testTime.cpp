#include <iostream>
#include <ctime>

using namespace std;

int main()
{
	//record current time
	time_t t = time(0);//get time now
	struct tm *now = localtime(&t);

	//pretty print for user
	cout << "The current time is: " <<  asctime(now) << endl;

	//Alternate pretty print
	//cout << put_time(&t, "%x") << endl;
}
