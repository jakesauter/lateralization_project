#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    /*
    //this line auto opens the file
    ofstream file("file.txt");

    cout << "Enter players ID, Name, and Money: ";
    cout << "Press Ctrl+z to quit" << endl;

    int idNum = 0;
    string name = " ";
    double money = 0.00;

    while(cin >> idNum >> name >> money)
    {
        file << idNum << " " << name << " " << money << endl;
    }

    file.close();
    */
    //now we will read files
    ifstream file("file.txt");

    int id = 0;
    string name = " ";
    double money = 0.00;

    while(file >> id >> name >> money)
    {
        cout << id << ", " << name << ", " << money << endl;
    }

    return 0;
}
