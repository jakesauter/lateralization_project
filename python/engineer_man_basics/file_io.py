# all about file io

#open/open modes

animals = open('animals.txt', 'a+')

"""
r = open for read (default)
w = open for write, truncate
r+ = open for read/write
w+ = open for read/write truncate
a+ = open for read/append
"""

# read lines
text = animals.read()
print text

# write/append

animals.write('frog \n')
animals.write('blue j \n')

# closing the file
animals.close()
