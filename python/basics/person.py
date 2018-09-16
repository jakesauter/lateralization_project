class Person:

    name = None
    age = None

    # Constructor
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def say_name(self):
        print "My name is", self.name

    def say_age(self):
        print "My age is", self.age
