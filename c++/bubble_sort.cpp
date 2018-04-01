#include <iostream>

using namespace std;

void sort(int * arr);

int main()
{
  int a[10];
  int x = 10;
  for(int i=0;i<10;i++)
  {
    a[i] = x;
    x--;
  }
  sort(a);
  return 0;
}

void sort(int* arr)
{
  int length = (sizeof(arr)/sizeof(arr[0]));
  cout << "length: " << length << endl;
  int temp;

  for(int i=0;i<length-1;i++)
  {
    for(int j=0;j<length-1;j++)
    {
      if(arr[j] > arr[j+1])
      {
        temp = arr[j];
        arr[j] = arr[j+1];
        arr[j+1] = temp;
      }
    }
  }

  for(int i=0;i<10;i++)
  {
    cout << arr[i] << " ";
  } 

  cout << endl;
}
