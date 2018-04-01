#include <iostream>
#include <stdlib.h>  
#include <time.h>//gives us access to the system clock

using namespace std;

int main()
{
	int *a;//pointer that points to an array of numbers on the heap
	int num;//how many numbers to generate
	int total = 0;//used to sum up all of the random numnbers that we generate
	cout << "How many random numbers would you like to add?: ";
	cin >> num;
 	a = new int[num];//will create an array on the heap that will be exactly as big as needed
	//now to generate random numbers
	srand(time(NULL));//time(NULL) retrieves the system clock
			  //srand90 is used to seed a random number generator
	for(int i=0;i<num;i++)
	{
		a[i] = rand()/1000;
		cout << a[i] << endl;
		total += a[i];
	}
	cout << "The total of " << num << " random numbers is: " << total << endl;
	return 0;
}
