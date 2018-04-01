#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

int main()
{
	int n, w;
	cout << "How many items are in the set?: ";
	cin >> n;
	n++;
	cout << "What is the weight restriction?: ";
	cin >> w;
	w++;
	//make table for dynamic approach
	int** V = new int*[n];
	for(int i = 0; i < n; i++)
	{
    		V[i] = new int[w];
	}
	//initialize both 1st row and 1st column to all 0s
	for(int i=0;i<n;i++)
	{
		V[i][0] = 0;
	}
	for(int i=0;i<w;i++)
	{
		V[0][i] = 0;
	}
	//now we can take in the items into another 2d array
	int** items = new int*[n];
	for(int i = 0; i < n; i++)
	{
    		items[i] = new int[2];
	}
	items[0][0] = 0;
	items[0][1] = 0;
	//each row will represent weight and values
	for(int i=1;i<n;i++)
	{	
		cout << "Please enter data for item " << i << endl;
		cout << "weight: ";
		cin >> items[i][0];
		cout << "value: ";
		cin >> items[i][1];
	}
	cout << "calculating . . ." << endl;
	//now we have all of the data and can perform the algorithm
	//we will do it row by row, left to right
	for(int i=1;i<n;i++)
	{
		//i will be the number of the item that we are working on 
		for(int j=1;j<w;j++)
		{
			if(items[i][0] < w && j-items[i][0] >= 0)//the item can be in the set
			{
				V[i][j] = max(items[i][1] + V[i-1][j-items[i][0]] , V[i-1][j]);
			}
			else
			{
				V[i][j] = V[i-1][j];
			}
		}
	}	
	cout << "The best value you can achieve is: " << V[n-1][w-1] << endl;
}
