#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
using namespace std;

int main()
{
	int x;
	//the rand library returns an int from 0 to RAND_MAX, which is defined by the <cstdlib>
	x = rand() % 10 + 1;//for 1-10
	//when using the standard printing library % allows for a post string argument, with the follow coordinations d or i->int, s->string, f->floating point, e ->scientific notation, g-> use the shortest representation, e or f, c->character, p -> pointer address, %% is to write a % to the screen 
	printf("random: %d \n",x);
	//or
	cout << "random: " << x << endl;
	return 0;
}
