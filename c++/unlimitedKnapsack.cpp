#include <iostream>

using namespace std;

int main()
{
	int *max, *sol, *mySol, *weight, *value, i, myFinalSol;
	int n, w, capacity;
	cout << "How many items are in the set?: ";
	cin >> n;
	cout << "What is the weight restriction?: ";
	cin >> w;
	max = new int[w+1];
	sol = new int[n];
	mySol = new int[n];
	weight = new int[n];
	value = new int[n];
	for(int j=0;j<n;j++)	
	{
		cout << "value for item " << j+1 << ": ";
		cin >> value[j];
		cout << "weight for item " << j+1 << ": ";
		cin >> weight[j];
	}
	max[0] = 0;
	//for debugging
	for(int j=0;j<n;j++)
	{
		cout << "Weight at " << j << " = " << weight[j] << endl;
		cout << "Value at " << j << " = " << value[j] << endl;	
	}
	for(capacity=1;capacity<=w;capacity++)
	{
		for(i=0;i<n;i++)
		{
			if(capacity >= weight[i])
			{
				sol[i] = max[capacity-weight[i]];//knapsack capacity reduced by weight[i] b/c it has item i packed in already
			}
			else
			{
				sol[i] = 0;//not enough space for the item
			}
		}
	}
	//debugging
	for(int j=0;j<n;j++)
	{
		cout << "Sol at " << j << " = " << sol[j] << endl;
	}
	//going back up
	for(i=0;i<n;i++)
	{
		if(capacity >= weight[i])
		{
			mySol[i] = sol[i] + value[i];
		}
		else
		{
			mySol[i] = 0;
		}
	}
	//find the max
	max[capacity] = mySol[0];
	for(i=1;i<n;i++)
	{
		if(mySol[i] > max[capacity])
		{
			max[capacity] = mySol[i];
		}
	}
	for(i=0;i<=w;i++)
	{
		cout << "max[" << i << "] = " << max[i] << endl;
	}
	cout << "The max is: " << max[w] << endl;
}
