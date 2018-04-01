with open("data.txt") as f: 
    arr = [word for line in f for word in line.split()]

s = arr[0][int(arr[1]):int(arr[2])+1]
s += " " + arr[0][int(arr[3]):int(arr[4])+1]
print s
