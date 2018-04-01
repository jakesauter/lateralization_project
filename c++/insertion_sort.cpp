#include <iostream>

using namespace std;

void InsertionSort(int arr[], int n)
{
    int j, temp;
    for(int i=0;i<n;i++)
    {
        j=i;
        while(j>0 && arr[j] < arr[j-1])
        {
            temp = arr[j];
            arr[j] = arr[j-1];
            arr[j-1] = temp;
            j--;
        }
    }
}

int main()
{
    int arr[4] = {4,2,3,1};
    InsertionSort(arr, 4);
    for(int i=0;i<4;i++)
    {
        cout << arr[i];
    }
    return 0;
}
