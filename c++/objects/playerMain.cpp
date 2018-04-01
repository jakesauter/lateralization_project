#include "player.h"
#include "enemy.h"
int main()
{
	player thePlayer = *new player();
	enemy e;
	e.Greet();
	thePlayer.Greet();
}
