import collections

f = open("data.txt", 'r')
degree = {}
f.readline()
for line in f:
    for w in line.split(): 
        if w in degree:
            degree[w] = degree[w]+1
        else:
            degree[w] = 1

od = collections.OrderedDict(sorted(degree.items()))
output = []
for k in od:
    output.append(od[k])

output = ' '.join([str(x) for x in output])
print output
