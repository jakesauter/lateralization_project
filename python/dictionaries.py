f = open("data.txt", 'r')
args = [w for line in f for w in line.split()]

"""we need to make a dictionary so that when we encounter 
   a new word it is added to the dictionary with def 1, and 
   when we encounter a known word we incriment the def by 1"""

dict = {}

for w in args: 
    if w in dict: 
        dict[w] = dict[w]+1
    else:
        dict[w] = 1

for k in dict:
    print k, dict[k]
