# All about functions

# define a functions
def my_function():
    # your code here
    print 'I am in a function!'

# arguments of a function
def add(num_1, num_2):
    result = num_1 + num_2
    return result

print "3+4=", add(3,4)

# multipler return
def square(num_1, num_2):
    return num_1**2, num_2**2

# calling

my_function()

result = add(2,3)
print result
result_1, result_2 = square(2,3)
print result_1, result_2
