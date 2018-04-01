import copy

def binary_search_helper(i, x, arr):
    n = len(arr)
    split = n/2
    if(len(arr) == 0):
        return -1
    elif(arr[split] == x):
        return split+i+1
    elif(arr[split] > x):
        return binary_search_helper(i, x, arr[:split])
    else:
        return binary_search_helper(i+split+1, x, arr[split+1:])

def binary_search(x, arr):
    return binary_search_helper(0,x,arr)

f = open("data.txt", 'r')
f.readline()
f.readline()
arr = [int(x) for x in f.readline().split()]
search = [int(x) for x in f.readline().split()]
output = []
for x in search:
    output.append(binary_search(x,arr))

o = open("output.txt", 'w')
sarr = [str(a) for a in output]
o.write(" " . join(sarr))
