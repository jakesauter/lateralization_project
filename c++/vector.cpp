#include <iostream>

using namespace std;

class Vector
{
	public: 
		Vector();
		Vector(int, int);
		void addItem(int);
		void delItem(void); 
		void print();
		int getStartSize();
		int getMaxSize();
		int getCurSize();
		int getGrowthSize();
		void setStartSize(int);
		void setMaxSize(int);
		void setCurSize(int);
		void setGrowthSize(int);
	private: 
		int startSize;
		int maxSize;
		int curSize;
		int growthSize;
		int* vector;
		void grow(void);
		void shrink(void);
};

Vector::Vector()
{
	startSize = maxSize = 7;
	curSize = 0;
	growthSize = 5;
	vector = new int[startSize];
}

Vector::Vector(int m, int g)
{
	startSize = maxSize = m;
	curSize = 0;
	growthSize = g;
	vector = new int[startSize];
}

void Vector::grow(void)
{
	
	//1:create temp vector of the same size
	int * temp = new int[maxSize];

	//2: copy exsisiting vector into temp vector
	for (int i = 0; maxSize; i++)
	{
		temp[i] = vector[i];
	}

	//3. delete the first vector
	delete[]vector;  //Note that[] are only bc the vector is an array

	//4. Create a new, bigger vector
	vector = new int[maxSize + growthSize];

	//5. Copy temp vector into new vect
	for (int i = 0; maxSize; i++)
	{
		vector[i] = temp[i];

	}

	//Misc
	delete[] temp;  // if we dont have the [] it will delete the first element
	maxSize += growthSize;

	cout << "Grow function called. maxSize=" << maxSize << endl;
}


void Vector::shrink(void)
{
		//1:create temp vector of the same size
	int * temp = new int[maxSize - growthSize];

	//2: copy exsisiting vector into temp vector
	for (int i = 0; maxSize; i++)
	{
		temp[i] = vector[i];
	}

	//3. delete the first vector
	delete[]vector;  //Note that[] are only bc the vector is an array

	//4. Create a new, bigger vector
	vector = new int[maxSize - growthSize];

	//5. Copy temp vector into new vect
	for (int i = 0; i <maxSize; i++)
	{
		vector[i] = temp[i];

	}

	//Misc
	delete[] temp;  // if we dont have the [] it will delete the first element
	maxSize -= growthSize;

	cout << "Grow function called. maxSize=" << maxSize << endl;

}


void Vector::addItem(int item)
{
	cout << "Adding " << item << "into posotion" << curSize << endl;
	vector[curSize] = item;
	curSize++;
	if(curSize == maxSize)//Condition indicates the vecotr is full
	{
		//trigger the grow function 
	}
}


void Vector::delItem(void)
{
	cout << vector[curSize-1] << "deleted" << endl; 
	curSize--;
	if(curSize == (maxSize - growthSize - 1))
	{
		shrink();
	}
}

int Vector::getStartSize()
{
	return startSize;
}

int Vector::getMaxSize()
{
	return maxSize;
}

int Vector::getCurSize()
{
	return curSize;
}


int Vector::getGrowthSize()
{
	return growthSize;
}

void Vector::setStartSize(int x)
{
	startSize = x;
}

void Vector::setMaxSize(int x)
{
	maxSize = x;
}

void Vector::setCurSize(int x)
{
	curSize = x;
}

void Vector::setGrowthSize(int x)
{
	growthSize = x;
}

void Vector::print()
{
	cout << "The current vector contains: ";
	for(int i=0;i<curSize;i++)
	{
		cout << vector[i] << " ";
	}
	cout << endl;	
}

int main()
{
	Vector v;
	v.addItem (10);
	v.addItem(15);
	v.addItem(8);
	v.addItem(12);
	v.addItem(32);
	v.addItem(64);
	v.addItem(54);
	v.addItem(3);
	v.addItem(12);
	v.delItem();
	v.delItem(); //Shrink
	v.delItem();
	v.delItem();
	v.delItem();
	return 0;
}
