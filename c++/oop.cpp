#include <iostream>
#include <string>

using namespace std;

class Student
{
	public:
	      Student();
	      string getFirstName();
	      string getLastName();
	      float getGPA();
	      void setFirstName(string s);
	      void setLastName(string s);
	      void setGPA(float f);
	      void print();
	      ~Student();
	private:
             string firstname;
	     string lastname;
	     float gpa;
	
};

Student::Student()
{
	firstname = "";
	lastname = "";
	gpa = 0.0;
}

string Student::getFirstName()
{
	return firstname;
}

string Student::getLastName()
{
	return lastname;
}

float Student::getGPA()
{
	return gpa;
}

void Student::setFirstName(string s)
{
	firstname = s;
}

void Student::setLastName(string s)
{
	lastname =s;
}

void Student::setGPA(float f)
{
	gpa = f;
}

void Student::print()
{
	cout << firstname << " " << lastname << " "  << gpa << endl;
}

Student::~Student()
{	
}

int main()
{
	Student s;//when declared like this the student will be on the stack
	s.setFirstName("Jake");
	s.setLastName("Sauter");
	s.setGPA(3.87);
	s.print();
	return 0;
}
