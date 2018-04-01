f = open("data.txt", 'r')
args = [ w for line in f for w in line.split() ]

a = int(args[0])
b = int(args[1])+1  #range is not inclusive

final_sum = 0
for i in range(a,b): 
    if i%2==1:
       final_sum+=i 
print final_sum
