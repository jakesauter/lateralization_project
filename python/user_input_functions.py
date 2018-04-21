from math import * #so user does not need to define math.func
import re

user_in = input("Please enter the function (all multiplications with *): ").replace("^", "**")
print("user_in: ", user_in)
f = lambda x : eval(user_in)

y = f(3)

print("f(3): ", y)
