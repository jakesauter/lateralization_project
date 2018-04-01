#include <iostream>

using namespace std;


template <class F, class S>

F smaller(F a, S b)
{
    return (a<b?a:b);
}

int main()
{
    int x=50;
    double y=43.2, z;
    //z = add(x,y);
    //cout << z << endl;
    cout << smaller(x,y);
    return 0;
}
